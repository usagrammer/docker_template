Param( [String]$container_name )
if ( [String]::IsNullOrEmpty($container_name) ) {
  echo 'Argument Error. please add container name.'
  exit
}
docker-compose exec ruby rails new . -d mysql
docker cp ./database.yml ${container_name}:/project/config/database.yml