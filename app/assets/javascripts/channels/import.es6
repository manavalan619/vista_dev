App.import = App.cable.subscriptions.create('ImportChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    const { id, filename, status } = data
    const statusCol = $(`#data_import_${id}`).find('.status')
    const linkCol = $(`#data_import_${id}`).find('.file-link')
    let icon, text

    switch (status) {
      case 'running':
        icon = 'fa-cog fa-spin'
        text = 'Running'
        break
      case 'finished':
        icon = 'fa-check'
        text = 'Finished'
        break
      case 'failed':
        icon = 'fa-exclamation-triangle'
        text = 'Failed'
        break
    }

    statusCol.html(`<i class="fa fa-fw ${icon}"></i> ${text}`)

    if (status === 'finished' || status === 'failed') {
      linkCol.html(`<a href="/data-imports/${id}">${filename}</a>`)
    }
  }
})
