# Fountain: A Ruby Docker Container DSL

Part of what makes [Docker](https://github.com/dotcloud/docker) so amazing is the use of [union mount filesystems](http://en.wikipedia.org/wiki/Union_mount). Using this feature we can build a library of hierarchical containers for use in development. Here is an example in which we create several enormous data containers with [Factory Girl](https://github.com/thoughtbot/factory_girl).

```ruby

fountain do
	
	image "postgres base", template: "zaiste/postgresql" do

		# we can shell out to the running postgres container
		# which will serve as our template.

		insert "/etc/pgsql/pg_hba.conf", "https://my.tld/pgsql/pg_hba.conf"
		invoke "/etc/init.d/pg_ctl start"

		image "a million users" do

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

Working on this part...

