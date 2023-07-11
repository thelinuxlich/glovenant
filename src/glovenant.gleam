import gleam/io

pub type Metadata {
  Metadata(description: String)
}

pub type SchemaType {
  VStr
  VInt
  VNumber
  VBoolean
  VList(SchemaType)
  VMap(String, SchemaType)
  VCustom(String)
}

pub type Parameter {
  Query(name: String, schema: SchemaType, metadata: Metadata)
  Body(name: String, schema: SchemaType, metadata: Metadata)
  Path(name: String, schema: SchemaType, metadata: Metadata)
  Header(name: String, schema: SchemaType, metadata: Metadata)
}

pub type ResponseBody {
  Success(schema: SchemaType, metadata: Metadata) // status 200
  Created(schema: SchemaType, metadata: Metadata) // status 201
  NotFound(schema: SchemaType, metadata: Metadata) // status 404
  BadRequest(schema: SchemaType, metadata: Metadata) // status 400
  InternalError(schema: SchemaType, metadata: Metadata) // status 500
}

pub type Endpoint {
  Get(
    alias: String,
    path: String,
    metadata: Metadata,
    params: List(Parameter),
    response: List(ResponseBody),
  )
  Post(
    alias: String,
    path: String,
    metadata: Metadata,
    params: List(Parameter),
    response: List(ResponseBody),
  )
  Put(
    alias: String,
    path: String,
    metadata: Metadata,
    params: List(Parameter),
    response: List(ResponseBody),
  )
  Delete(
    alias: String,
    path: String,
    metadata: Metadata,
    params: List(Parameter),
    response: List(ResponseBody),
  )
  Patch(
    alias: String,
    path: String,
    metadata: Metadata,
    params: List(Parameter),
    response: List(ResponseBody),
  )
}

pub type Contract {
  Contract(List(Endpoint))
}

pub fn main() {
  let pokemon_api_spec =
    Contract([
      Get(
        alias: "pokemon_by_name",
        path: "/pokemon/:name",
        metadata: Metadata("Get a pokemon by name"),
        params: [Path("name", VStr, Metadata("The name of the pokemon"))],
        response: [
          Success(
            schema: VCustom("Pokemon"),
            metadata: Metadata("The pokemon info"),
          ),
          NotFound(
            schema: VCustom("Not Found"),
            metadata: Metadata("The pokemon was not found"),
          ),
        ],
      ),
      Post(
        alias: "create_pokemon",
        path: "/pokemon",
        metadata: Metadata("Create a pokemon"),
        params: [
          Body("name", VStr, Metadata("The name of the pokemon")),
          Body("type", VStr, Metadata("The type of the pokemon")),
          Body("height", VNumber, Metadata("The height of the pokemon")),
          Body("weight", VNumber, Metadata("The weight of the pokemon")),
          Body(
            "is_legendary",
            VBoolean,
            Metadata("Is the pokemon legendary?"),
          ),
        ],
        response: [
          Success(
            schema: VCustom("OK"),
            metadata: Metadata("The created pokemon"),
          ),
          BadRequest(
            schema: VCustom("Bad Request"),
            metadata: Metadata("The pokemon was not created"),
          ),
        ],
      ),
    ])
}

pub fn forge(c: Contract) {
  todo
}
