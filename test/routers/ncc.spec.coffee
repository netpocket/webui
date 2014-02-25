describe 'Ncc Router', ->
  beforeEach ->
    @router = new nccWebui.Routers.NccRouter()

  describe 'index route', ->
    collClass = nccWebui.Collections.DevicesCollection
    conn = null
    connOpts = null
    viewOpts = null
    renderSpy = null
    beforeEach ->
      renderSpy = sinon.stub().returns({el:''})
      nccWebui.Views._DevicesView = nccWebui.Views.DevicesView
      nccWebui.Views.DevicesView = class extends Backbone.View
        initialize: (options) ->
          viewOpts = options
        render: renderSpy
      nccWebui.Models._ConnectionModel = nccWebui.Models.ConnectionModel
      nccWebui.Models.ConnectionModel = class extends Backbone.Model
        initialize: (options) ->
          connOpts = options
          conn = @
      fn = @router[@router.routes['ncc/:token/:host']]
      fn('mytoken', 'somehost')

    afterEach ->
      nccWebui.Views.DevicesView = nccWebui.Views._DevicesView
      nccWebui.Models.ConnectionModel = nccWebui.Models._ConnectionModel

    it 'creates a connection and attaches it to the root object', ->
      expect(nccWebui.connection).to.deep.eq(conn)

    it 'uses the same devices collection to build view and connection', ->
      expect(viewOpts).to.deep.eq(connOpts.devices)

    describe 'connection constructor', ->
      it 'is passed a token from the url', ->
        expect(connOpts.token).to.eq('mytoken')

      it 'is passed a url taken from the route', ->
        expect(connOpts.url).to.eq('http://somehost')

      it 'is passed a devices collection', ->
        expect(connOpts.devices).to.be.an.instanceof collClass

    describe 'devices view', ->
      it 'is rendered', ->
        expect(renderSpy).to.have.been.called

      it 'is passed a devices collection', ->
        expect(viewOpts).to.be.an.instanceof collClass

