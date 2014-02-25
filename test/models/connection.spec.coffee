describe.only 'Connection Model', ->
  conn = null
  socket = null
  beforeEach ->
    sinon.stub(Primus, 'connect').returns(sparkStub())
    conn = new nccWebui.Models.ConnectionModel
      url: 'a url'
      token: 'a token'
      devices: {add:sinon.stub(), remove: sinon.stub()}
    socket = conn.socket

  afterEach ->
    Primus.connect.restore()

  describe 'identification', ->
    it 'listens for the identification request', ->
      expect(socket).to.listenOn('please identify')

    it 'identifies as a web browser, supplying a token and tail', ->
      socket.onCallback('please identify')()
      expect(socket).to.write('i am a web browser', 'a token', {})

  describe 'device add', ->
    it 'listens for device appearance', ->
      expect(socket).to.listenOn('a wild device appears')

    it 'adds it to the device collection', ->
      socket.onCallback('a wild device appears')({some:'data'})
      expect(conn.devices.add).to.have.been.calledWith({some:'data'})

  describe 'device remove', ->
    it 'listens for device appearance', ->
      expect(socket).to.listenOn('a wild device disconnected')

    it 'adds it to the device collection', ->
      socket.onCallback('a wild device disconnected')({some:'data'})
      expect(conn.devices.remove).to.have.been.calledWith({some:'data'})

