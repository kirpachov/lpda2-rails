FROM ruby:3.1.3 AS lpda2-rails
WORKDIR /app
COPY . .
RUN bundle install
CMD bundle exec rails s

# -- Stage 2 --
# # Create the final environment with the compiled binary.
# FROM alpine
# RUN apk --no-cache add ca-certificates
# WORKDIR /root/
# COPY --from=builder /app/bin/hello /usr/local/bin/
# CMD ["hello"]
