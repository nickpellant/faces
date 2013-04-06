# Faces: Standardized Multi-Avatar Framework

[![Gem Version](https://badge.fury.io/rb/faces.png)][gem]
[![CI Build Status](https://secure.travis-ci.org/nickpellant/faces.png?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/nickpellant/faces.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/nickpellant/faces/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/faces
[travis]: http://travis-ci.org/nickpellant/faces
[codeclimate]: https://codeclimate.com/github/nickpellant/faces
[coveralls]: https://coveralls.io/r/nickpellant/faces

**Faces 1.0 is a complete rewrite and is not compatible with any previous release.**

## Introduction

Faces is a framework that standardizes the implementation of using multiple avatar providers within web applications. Any developer can create a strategies for an avatar provider to be used in conjunction with Faces.

In order to use Faces in your applications, you will need to leverage one or more strategies. These strategies are generally released individually as RubyGems.

This library is heavily inspired by [OmniAuth](https://github.com/intridea/omniauth) in its implementation, as is this README. Big kudos to [Intridea](http://intridea.com) for creating such an awesome library.

## Installation

Add this line to your application's Gemfile:

    gem 'faces'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faces