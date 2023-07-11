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
  Query(Field)
  Body(Field)
  Path(Field)
  Header(Field)
}

pub type Field {
  Field(name: String, schema: SchemaType, metadata: Metadata)
}

pub type ResponseBody {
  ResponseBody(status_code: Int, schema: SchemaType, metadata: Metadata)
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
        params: [Path(Field("name", VStr, Metadata("The name of the pokemon")))],
        response: [
          ResponseBody(
            status_code: 200,
            schema: VCustom("Pokemon"),
            metadata: Metadata("The pokemon info"),
          ),
          ResponseBody(
            status_code: 404,
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
          Body(Field("name", VStr, Metadata("The name of the pokemon"))),
          Body(Field("type", VStr, Metadata("The type of the pokemon"))),
          Body(Field("height", VNumber, Metadata("The height of the pokemon"))),
          Body(Field("weight", VNumber, Metadata("The weight of the pokemon"))),
          Body(Field(
            "is_legendary",
            VBoolean,
            Metadata("Is the pokemon legendary?"),
          )),
        ],
        response: [
          ResponseBody(
            status_code: 201,
            schema: VCustom("OK"),
            metadata: Metadata("The created pokemon"),
          ),
          ResponseBody(
            status_code: 400,
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
