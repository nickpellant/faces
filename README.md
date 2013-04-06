# Faces: Standardized Multi-Avatar Framework

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