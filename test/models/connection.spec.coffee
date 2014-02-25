# global describe, beforeEach, assert, it
"use strict"

describe 'Connection Model', ->
  beforeEach ->
    @Connection = new nccWebui.Models.ConnectionModel();
