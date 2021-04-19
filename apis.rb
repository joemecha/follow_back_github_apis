# Write a program to follow GH followers not already followed

# PART I
# Hit an API endpoint to get all followers
# Authenticate to tell the API who I am
# Need to send Auth token

require 'faraday'
require 'pry'
require 'json'
require './git_hub_service'

# response = Faraday.get 'http://api.github.com/user/followers'
token = 's0met0ken' # get real token from github settings from: https://github.com/settings/tokens
service = GitHubService.new(token)

followings = service.get_followings.map do |following_hash|
  following_hash[:login]
end

# For each follower
service.get_followers.each do |follower_hash|
  follower_username = follower_hash[:login]
  # Print out all follower names
  puts "Follower: #{follower_username}"
  # Check if already following
  if followings.include? follower_username
    # If already, print a message
    puts "Already following: #{follower_username}"
  else
    # If not already following, follow back
    puts "Not following: #{follower_username}. Now following back."
    service.follow(follower_username)
  end
end
