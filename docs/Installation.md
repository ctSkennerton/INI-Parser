# Installation

## Basic Installation

You can load **INI Parser** evaluating:

```smalltalk
Metacello new
  baseline: 'INIParser';
  repository: 'github://ctSkennerton/INI-Parser:master';
  load.
```

> Change `master` to some released version if you want a pinned version

## Using as dependency

In order to include **INI Parser** as part of your project, you should
reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

  spec
    baseline: 'INIParser'
      with: [ spec
        repository: 'github://ctSkennerton/INI-Parser:v{XX}'];
    project: 'INIParser-Deployment'
      copyFrom: 'INIParser'
      with: [ spec loads: 'Deployment' ].
```

> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

  <baseline>
  spec
    for: #common
    do: [ self setUpDependencies: spec.
      spec package: 'My-Package'
        with: [ spec requires: #('INIParser-Deployment') ] ]
```

## Provided groups

- `Deployment` will load all the packages needed in a deployed application
- `Tests` will load the test cases
- `CI` is the group loaded in the continuous integration setup
- `Development` will load all the needed packages to develop and contribute to
  the project
