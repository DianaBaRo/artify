How to build a CLI Gem:

	1. Plan your gem, imagine your interface
	A command line interface for art exhibitions, starting with:
	
	-User types "art-exhibitions"
	
	-Show a list of exhibitions
	
		a. Exhibition title - where - available until date
		b. […]
	
	- Which exhibition do you want to learn more about?



	2. Start with the project structure - google
		Google how to build a gem? https://guides.rubygems.org/make-your-own-gem/
		Make a gem using Bundle http://railscasts.com/episodes/245-new-gem-with-bundler
		How build a cli gem. Research about patterns to create gems


	3. Start with the entry point - the file run.
		a. The executable, that into the bin. Because is not a Ruby file I need to put: #!/usr/bin/env ruby
	
		
	4. Force that to build the CLI interface
		a. Build the logic inside the cli.rb, the cli controller. Even with harcoded data
	5. Stub out the interface
	6. Start making things real
		a. So now we go to the art exhibitions list and I think, what is an art exhibition. 
			i. An exhibition has a name
			ii. A place
			iii. An availability
			iv. An url for more info
		b. This is my first object
		
		
	7. Discover objects
	8. Program
