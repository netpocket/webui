# global describe, beforeEach, assert, it
"use strict"

describe 'Devices View', ->
  beforeEach ->
    @Devices = new nccWebui.Views.DevicesView();
