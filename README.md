# SWVLMovies
SWVLMovies is an iOS application built as interview task at Swvl. Built Using MVP (Model-View-Presenter) and Clean Architecture concepts

### Run Requirements

* Xcode 10.2
* Swift 5

### Installation

1. Clone the porject.
2. Navigate to project folder in terminal.
3. Run `make bootstrap`

### High Level Layers

#### MVP Concepts (Presentation Logic or Scenes)
* **`View`** - delegates user interaction events to the `Presenter` and displays data passed by the `Presenter`
* All `UIViewController`, `UIView`, `UITableViewCell` subclasses belong to the `View` layer
* Usually the view is passive / dumb - it shouldn't contain any complex logic and that's why most of the times I don't need write Unit Tests for it
* **`Presenter`** - contains the presentation logic and tells the `View` what to present
* Usually I have one `Presenter` per scene (view controller)
* It doesn't reference the concrete type of the `View`, but rather it references the `View` protocol that is implemented usually by a `UIViewController` subclass
* It should be a plain `Swift` class and not reference any `iOS` framework classes - this makes it easier to reuse it maybe in a `macOS` application
* It should be covered by Unit Tests
* **`Configurator`** - injects the dependency object graph into the scene (view controller)
* Unfortunately DI libraries are not quite mature yet on `iOS` / `Swift`
* Usually it contains very simple logic and I don't need to write Unit Tests for it
* **`Router`** - contains navigation / flow logic from one scene (view controller) to another
* In some communities / blog posts it might be referred to as a `FlowController`
* Writing tests for it is quite difficult because it contains many references to `iOS` framework classes so usually I try to keep it really simple and I don't write Unit Tests for it
* It is usually referenced only by the `Presenter` but due to the `func prepare(for segue: UIStoryboardSegue, sender: Any?)` method I some times need to reference it in the view controller as well

#### Clean Architecture Concepts

##### Application Logic (Core)

* **`UseCase / Interactor`** - contains the application / business logic for a specific use case in your application
* It is referenced by the `Presenter`. The `Presenter` can reference multiple `UseCases` since it's common to have multiple use cases on the same screen
* It manipulates `Entities` and communicates with `Gateways` to retrieve or persist the entities
* **`Gateway`** is defiend as a protocols and should be defined in the `Application Logic` layers and implemented by the `Gateways & Framework Logic`
* The separation described above ensures that the `Application Logic` depends on abstractions and not on actual frameworks or implementations
* It should be covered by Unit Tests
* **`Entity`** - plain `Swift` classes or structs
* Models objects used by your application such as `Movie` or what ever needed

##### Gateways & Framework Logic (EntityGateway)

* **`Gateway`** - contains actual implementation of the protocols defined in the `Application Logic` layer
* We can implement for instance a `LocalPersistenceGateway` protocol using `CoreData` or `Realm`
* We can implement for instance an `ApiGateway` protocol using `URLSession` or `Alamofire`, and that I going to use in the scope of task
* It should be covered by Unit Tests
* **`Persistence / API Entities`** - contains framework specific representations
* For instance we could have a `APIMovie` that is conform `Codable` or `Mappaple`
* The `APIMovie` would not be passed to the `Application Logic` layer but rather the `Gateways & Framework Logic` layer would have to "transform" it to an `Movie` entity defined in the `Application Logic` layer
