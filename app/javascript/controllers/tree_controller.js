import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "top"]
  static values = {owner: String}

  connect() {
    this.expanded = "\u25BC" // down triangle
    this.collapsed = "\u25bA" // right triangle
    this.itemTargets.forEach(item => this.attach(item))
  }

  attach(item) {
    item.addEventListener("dragstart", e => this.dragStart(e, item))
    item.addEventListener("dragend",   e => this.dragEnd(e, item))
    item.addEventListener("dragover",  e => this.dragOver(e, item))
    item.addEventListener("drop",      e => this.drop(e, item))
  }

  dragStart(e, el) {
    e.stopPropagation()

    // ev.dataTransfer.setData("text/plain", "")
    this.dragged = el
    e.dataTransfer.effectAllowed = "move"
    el.classList.add("dragging")
  }

  dragEnd(e) {
    e.stopPropagation()
    this.dragged.classList.remove("dragging")
    this.dragged = null
  }

  dragOver(e, el) {
    e.preventDefault()
  }

  drop(e) {
    e.stopPropagation()

    const dragged = this.dragged
    const target = e.currentTarget
    // this.testUtilities(target)

    if (dragged == target) {
      this.doGrouping(target)
    } else {
      this.drop2(e, dragged, target)
      this.sendOrder(target)
    }
  }

  drop2(e, dragged, target) {
    const children = target.lastElementChild
    if (this.isNode(target)) {
      if (this.isNodeEmpty(target)) {
        children.appendChild(dragged)
        return
      }
    }

    const rect = target.getBoundingClientRect()
    const offset = e.clientY - rect.top
    const threshold = (rect.height / 3) * 2

    const target2 = (offset > threshold) ? target.nextSibling : target
    target.parentNode.insertBefore(dragged, target2)
  }

  doGrouping(elem) {
    if (this.isNode(elem)) {
      if (!this.isNodeEmpty(elem)) {
        throw "MiniTreeView: Node has children; can't be converted to leaf"
      }

      this.toLeaf(elem)
    } else {
      this.toNode(elem)
    }
  }

  toLeaf(elem) {
    var row = elem.firstElementChild
    const newRow = this.create("span", {className: "toggle-space"})

    this.removeUl(elem)
    row.removeChild(row.firstElementChild)
    row.insertBefore(newRow, row.children[0])

    this.sync({owner: this.ownerValue, function: "node2leaf",
      value: elem.dataset.itemId})
  }

  toNode(elem) {
    var row = elem.firstElementChild
    const newRow = this.create("a", {className: "toggle-btn",
      textContent: this.expanded})
    //  type: "button", textContent: this.expanded})

    this.removeUl(elem)
    const ulRow2 = this.create("ul", {className: "nested"})
    elem.insertBefore(ulRow2, elem.children[1])
    row.removeChild(row.firstElementChild)
    row.insertBefore(newRow, row.children[0])

    this.sync({owner: this.ownerValue, function: "leaf2node",
      value: elem.dataset.itemId})
  }

  removeUl(elem) {
    const ulRow = elem.children[1]
    if (ulRow) elem.removeChild(ulRow)
  }

  toggle(e) {
    const li = e.currentTarget.closest(".tree-item")
    const id = li.dataset.itemId
    const list = li.querySelector(".nested")
    if (!list) return

    const btn  = li.querySelector(".toggle-btn")
    const hide = list.classList.toggle("hidden")
    if (btn) btn.textContent = hide ? this.collapsed : this.expanded
    this.sync({owner: this.ownerValue, function: "toggle",
      id: id, value: hide})
  }

  ///////////////////////// Utilities ////////////////////////////////

  testUtilities(el) {
    console.log("***** testUtilities *****", el)
    console.log("isLeaf", this.isLeaf(el))
    console.log("isNode", this.isNode(el))
    console.log("isNodeEmpty", this.isNodeEmpty(el))
    console.log("parent", this.parent(el))
    console.log("parent_id", this.parent_id(el))
  }

  create(tag, attrs) {
    var elem = document.createElement(tag)
    Object.assign(elem, attrs)
    return elem
  }

  isLeaf(elem) {
    const el = elem.firstElementChild.firstElementChild
    return el.tagName == "SPAN"
  }

  isNode(elem) {
    return !this.isLeaf(elem)
  }

  isNodeEmpty(elem) {
    const el = elem.lastElementChild
    if (el.childElementCount == 0) return true
    return false
  }

  parent(elem) {
    return elem.parentElement.closest("li")
  }

  parent_id(elem) {
    elem = this.parent(elem)
    if (!elem) return null
    return elem.dataset.itemId
  }

  ///////////////////////// AJAX ////////////////////////////////

  flatted = (elem) => {
    const result = []
    var id = elem.dataset.itemId
    var parent_id = this.parent_id(elem.parentElement)

    if (id && id != 0) { result.push([id, parent_id]) }
    for (var elem2 of elem.children) {
      result.push(...this.flatted(elem2))
    }
    return result
  }

  sendOrder(el) {
    const flat = this.flatted(this.topTarget.parentElement)
    this.sync({owner: this.ownerValue, function: "order",
      order: JSON.stringify(flat)})
  }

  async sync(params) {
    const url = "/mini_trees/sync"
    const token = document.querySelector("meta[name=csrf-token]").content
    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": token
        },
        body: JSON.stringify(params)
      })

      if (!response.ok) {
        throw new Error(`Response status: ${response.status}`);
      }

      // const result = await response.json();
      // console.log(result);
    } catch (error) {
      console.error(error.message);
    }
  }
}



//  over(e, el) {
//console.log("over")
//    e.preventDefault()
//    if (this.dragged === el) return
//    const rect = el.getBoundingClientRect()
//    const offset = e.clientY - rect.top
//    const third = rect.height / 3
//
//    if (offset < third) {
//      el.parentNode.insertBefore(this.placeholder, el)
//    } else if (offset > 2 * third) {
//      el.parentNode.insertBefore(this.placeholder, el.nextSibling)
//    } else {
//      let ul = el.querySelector(".nested")
//      if (!ul) {
//        ul = document.createElement("ul")
//        ul.className = "nested"
//        el.appendChild(ul)
//      }
//      ul.classList.remove("hidden")
//      ul.appendChild(this.placeholder)
//    }
//  }
//
//  removePlaceholder() {
//    this.placeholder?.remove()
//  }
//
//
// // rails javascript no jquery no sortablejs use stimulus sortable treeview
// // expand collapse support
// // nested reordering
//
//
// // https://wiki.selfhtml.org/wiki/JavaScript/Drag_%26_Drop
// // https://developer.mozilla.org/en-US/docs/Web/API/HTML_Drag_and_Drop_API
