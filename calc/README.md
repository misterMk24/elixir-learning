# Calc

Simple Calculator project for learing purposes.


#### Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `calc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:calc, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/calc>.


#### Description

There is main function `start/0` which is the entrypoint for the project.
Function will be working until you provide an `exit` command.

#### Getting started

Run the Elixir console under the `/calc` folder with the following command:
```bash
iex -S mix
```

#### Example:

```elixir
> Calc.start()
Enter your expression:
> 1 + 2
Result: 3.0

Enter your expression:
> exit
See you!
:ok
```



