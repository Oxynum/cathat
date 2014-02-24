Swagger::Docs::Config.register_apis({
  "0.1" => {
    # the extension used for the API
    # the output location where your .json files are written to
    :api_file_path => "public/api/v0/", 
    # the URL base path to your API 
    :base_path => "http://0.0.0.0:3000", 
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    :formatting => :pretty
  }
})

class Swagger::Docs::Config
  def self.transform_path(path)
    "http://0.0.0.0:3000/api/#{path}"
  end
end