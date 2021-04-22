Param( [String]$container_name )
if ( [String]::IsNullOrEmpty($container_name) ) {
  echo 'Argument Error. please add container name.'
  exit
}
docker-compose exec ruby rails new . -d mysql
docker cp ./database.yml ${container_name}:/project/config/database.yml
docker-compose exec ruby yarn
docker-compose exec ruby bundle
docker-compose exec ruby rails db:migrate
docker-compose exec -d ruby rails server -b '0.0.0.0'