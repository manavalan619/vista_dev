const {defer, dispatch} = Turbolinks;

const handleEvent = (eventName, handler) => document.addEventListener(eventName, handler, false);

const translateEvent = function({from, to}) {
  const handler = function(event) {
    event = dispatch(to, {target: event.target, cancelable: event.cancelable, data: event.data});
    if (event.defaultPrevented) { return event.preventDefault(); }
  };
  return handleEvent(from, handler);
};

translateEvent({from: "turbolinks:click", to: "page:before-change"});
translateEvent({from: "turbolinks:request-start", to: "page:fetch"});
translateEvent({from: "turbolinks:request-end", to: "page:receive"});
translateEvent({from: "turbolinks:before-cache", to: "page:before-unload"});
translateEvent({from: "turbolinks:render", to: "page:update"});
translateEvent({from: "turbolinks:load", to: "page:change"});
translateEvent({from: "turbolinks:load", to: "page:update"});

let loaded = false;
handleEvent("DOMContentLoaded", () =>
  defer(() => loaded = true)
);
handleEvent("turbolinks:load", function() {
  if (loaded) {
    return dispatch("page:load");
  }
});

if (typeof jQuery === 'function') {
  jQuery(document).on("ajaxSuccess", function(event, xhr, settings) {
  if (jQuery.trim(xhr.responseText).length > 0) {
    return dispatch("page:update");
  }
});
}
