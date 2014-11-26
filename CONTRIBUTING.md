# Contributing

## Developing

If you'd like to submit a patch:

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add [tests](#testing) for it. This is important so that it isn't broken in a
   future version unintentionally.
4. Commit. **Do not touch any unrelated code, such as the gemspec or version.**
   If you must change unrelated code, do it in a commit by itself, so that it
   can be ignored.
5. Send a pull request.

## Testing

### Install prerequisites

Install git on your test system.

Install the latest version of [Bundler](http://gembundler.com)

    $ gem install bundler

Clone the project

    $ git clone git://github.com/berkshelf/berkshelf.git

and run:

    $ cd berkshelf
    $ bundle install

Bundler will install all gems and their dependencies required for testing and developing.

### Running unit (RSpec) and acceptance (Cucumber) tests

We use Chef Zero - an in-memory Chef Server for running tests. It is automatically managed by the Specs and Cukes. Simply run:

    $ bundle exec guard start

See [here](https://github.com/tdegrunt/vagrant-chef-server-bootstrap) for a
quick way to get a testing chef server up.

On windows, setting up guard and running it can be challenging. Try:

    C:\berkshelf>bundle binstub guard
    C:\berkshelf>start ruby.exe bin\guard start

To make the warning about colored output go away, git clone [ansicon](https://github.com/adoxa/ansicon), and build/install it.

    Setting environment for using Microsoft Visual Studio 2010 x86 tools.
    
    C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC>pushd C:\ansicon
    C:\ansicon>nmake /f makefile.vc BITS=32
    ... build spew ...
    C:\ansicon>pushd x86
    C:\ansicon\x86>ansicon.exe -i
    ANSICON: parent is 64-bit (use x64\ansicon).

The build for x64 ansicon certainly runs, but installing it made my console consistently barf about missing the x86 ansicon dll.

### Debugging Issues
By default, Berkshelf will only give you the top-level output from a failed command. If you're working deep inside the core, an error like:

    Berkshelf Error: wrong number of arguments (2 for 1)

isn't exactly helpful...

Specify the `BERKSHELF_DEBUG` flag when running your command to see a full stack trace and other helpful debugging information.
