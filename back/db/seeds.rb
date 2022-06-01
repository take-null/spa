User.all.each_with_index do |user, num|
    user.tweets.create!(
        tweet_content: "test tweet#{num + 1}"
    )
end