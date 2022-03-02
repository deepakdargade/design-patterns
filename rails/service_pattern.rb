require "down"

class FileDownloaderService
  def self.call(url)
    tempfile = Down.download(url)
    tempfile.read.to_s
  end
end

puts FileDownloaderService.call("https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?index=3")
# Output =>
#[
# {
#   "fact": "Apple and pear seeds contain arsenic, which may be deadly to dogs."
# }
#]