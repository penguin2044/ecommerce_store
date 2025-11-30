FROM ruby:3.4.7

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client npm && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /rails

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]