require_relative "lib/routing"

use Rack::Deflater
$stdout.sync = true

run Routing
