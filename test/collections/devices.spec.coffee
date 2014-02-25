# global describe, beforeEach, assert, it
"use strict"

describe 'Devices Collection', ->
  beforeEach ->
    @Devices = new nccWebui.Collections.DevicesCollection()
