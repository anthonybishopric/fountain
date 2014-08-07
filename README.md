# Fountain: A Ruby Docker Container DSL

Part of what makes [Docker](https://github.com/dotcloud/docker) so amazing is the use of [union mount filesystems](http://en.wikipedia.org/wiki/Union_mount). Using this feature we can build a library of hierarchical containers for use in development. Here is an example in which we create several enormous data containers with [Factory Girl](https://github.com/thoughtbot/factory_girl).

```ruby
# test/fountain/big_user_db.rb
fountain do

	image :postgres_base, from: "zaiste/postgresql" do

		# We specify options just as we would in a Dockerfile. Options
		# are inherited by sub-images.

		add "https://my.tld/pgsql/pg_hba.conf", "/etc/pgsql/pg_hba.conf"
		cmd "postgres -D /usr/local/pgsql/data"

		image :a_million_users do

			1000000.times do
				FactoryGirl.create(:user)
			end

			image "with other features" do
				# inherits the 1M users, can do even more in here
			end

		end

	end

end

```

Building these initially is slow, but not only are they easy to keep up to date, they can be rebooted over and over inexpensively!

## How to use

```bash
$ fountain build test/fountain/big_user_db.rb
--> Built "postgres_base"
--> Built "postgres_base__a_million_users"
--> Built "postgres_base__a_million_users__with_other_features"
Done
```

You can now run these containers directly.

```bash
$ docker run -dP postgres_base__a_million_users
adce4519dca281fe5c6d7a84cf92b
```

## Attach to a Custom Docker Host

You can pass the `-H` option to the `fountain` command to have it override the location of the Docker host. The syntax for `-H` is the same as the `-H` used when starting Docker. See [the Docker basics](https://docs.docker.com/articles/basics/#bind-docker-to-another-hostport-or-a-unix-socket) for more information.