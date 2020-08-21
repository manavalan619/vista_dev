App.import = App.cable.subscriptions.create('ReleaseChannel', {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    const { id, status } = data
    const statusCol = $(`#release_${id}`).find('.status')
    const downloadCol = $(`#release_${id}`).find('.download')
    let icon, text

    switch (status) {
      case 'processing':
        icon = 'fa-cog fa-spin'
        text = 'Processing'
        break
      case 'complete':
        icon = 'fa-check'
        text = 'Complete'
        break
    }

    statusCol.html(`<i class="fa fa-fw ${icon}"></i> ${text}`)

    if (status === 'complete') {
      downloadCol.html(`<a href="/releases/${id}/download">Download</a>`)
    }
  }
})
