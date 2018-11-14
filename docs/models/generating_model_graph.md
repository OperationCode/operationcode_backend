# Graph of the app's models

We use [Rails ERD](https://github.com/voormedia/rails-erd) to automatically generate a graph of the projects data models whenever migrations are run.


## Generating a Graph

### Automatically
This happens when migrations are run during `make setup`

### Manually
If you need to regenerate the graph, first make sure the docker containers are running, then use this command:
`docker-compose run web bundle exec erd`

Your graph will be outputed to `docs/models/model_graph.png`

## Graph Options

Graph options are controled by the `.erdconfig` yaml file. Rails-ERD has documentation on all of the available options [here](https://voormedia.github.io/rails-erd/customise.html), but the ones we include will be documented below.

| Option                 | Description                                                                                                                                   |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| filename               | path and file name where the model will be generated                                                                                          |
| filetype               | file type and extension to be used, see [Graphviz's documentation](https://www.graphviz.org/doc/info/output.html) for complete available list |
| title                  | title to be added to the graph                                                                                                                |
| attribute              | this section specifies which attributes to include in the graph                                                                               |
| attribute/foreign_keys | any foreign key column used for associations                                                                                                  |
| attribute/primary_keys | the primary key for that model, usually `id`                                                                                                  |
| attribute/timestamps   | timestamp fields such as `created_at` or `updated_on`                                                                                         |
| attribute/inheritance  | the single table inheritance column, typically `type`                                                                                         |
| attribute/content      | all other columns                                                                                                                             |
| notation               | the type of documentation, can be either `simple` or `bachman`                                                                                |
| orientation            | `vertical` or `horizontal`, which direction the graph will favor when organizing itself                                                      |
| warn                   | show or hide warnings when generating the graph, `true` or `false`                                                                            |

### Notation Types
There are a few differences between the notation types. The basics are detailed here, but for more indepth examples see the documentation [here](https://voormedia.github.io/rails-erd/gallery.html#notations).

#### Simple
| relationship           | model relationship        | line type                                                                                                                                                             |
| ---------------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| One to One             | `has_one`, `belongs_to`   | straight line, no arrows or decoration                                                                                                                                |
| One to Many            | `has_many`,`belongs_to`   | straight line, arrow pointing towards object that belongs to other object                                                                                             |
| Many to Many           | `has_and_belongs_to_many` | straight line, with arrows pointing towards both objects                                                                                                              |
| Many to Many with Join | `has_many`,`belongs_to`   | Direct One to Many relationships: straight line with arrow towards object that belongs to other object. Indirect Many to Many relationship: dotted line with an arrow |

#### Bachman

This graph notation is different from the simple notation in that it includes information if a relationship is optional or required.
This is represented by closed and open dots at the start and end of the relationship line. An open dot means that the relationship is optional from the object the dot is attached to. A closed dot means the relationship is required from the object the dot is attached to.
