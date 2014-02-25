# global describe, beforeEach, assert, it
"use strict"

describe 'Ncc Router', ->
  beforeEach ->
    @Ncc = new nccWebui.Routers.NccRouter();

  it 'index route', ->

