## 0.5.0

* Initial gem release

## 0.6.0

### New features

* Added configuration - disable_preload for use with integration tests
* Added configuration - adapter to control caching of factory references. Relevant for integration tests
* Changed the way the factory references are handled when they are loaded

## 0.6.1

### Bug fix

* speedy factory is now raising Gonzales::UndefinedAssociation if association is missing
  instead of undefined method `macro' for nil:NilClass

