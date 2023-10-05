Ruby Version - 2.7.2
Rails Version - 5.1.7

Steps to run - 
- take clone of the repo
- go to the root directory
- run bundle install
- open database.yml and change the credential accordingly
- run rake db:create
- run rake db:migrate
- run export OPEN_WEATHER_API_KEY=7a3687f6eb8d5338ab0f27ad7ce42899 (this is the openweatherapi key). Set this environment variable in every terminal window where you will run the app
- run rake db:seed (This will take some time as we are fetching historical data from last 1 year and you will be able to see the exact sequence of operations. make sure environment varibale is set)
- start redis server (Make sure environment varibale is set)
- start sidekiq server (You will see logs of the jobs here. There is one job which runs every minute and prints Hello Abhijit. ImportAirPollutionDataJob runs every one hour to fetch the data.)
- run rails server on port 8000 using rails s -p 8000

Go to postman or any too you use to run apis
average_quality_index_per_month_per_location - http://localhost:8000/api/air_pollution_records/average_quality_index_per_month_per_location
average_quality_index_per_location - http://localhost:8000/api/air_pollution_records/average_quality_index_per_location
average_quality_index_per_state - http://localhost:8000/api/air_pollution_records/average_quality_index_per_state

For the test cases I have used rspec
-  Just go to the root folder and run rspec

The importer runs every one hour. 
- If you want to run it just go to rails console and run ImportAirPollutionDataJob.perform_now **OR** you can change cron expression in schedule.yml to run this every minute.



