const html = document.querySelector('html');
const classList = html.classList;

const add = function add(className) {
  return classList.add(className);
};

const remove = function remove(className) {
  return classList.remove(className);
};

const toggle = function toggle(className, force) {
  return classList.toggle(className, force);
};

const htmlClasses = {
  add: add,
  remove: remove,
  toggle: toggle
};

export default htmlClasses;
