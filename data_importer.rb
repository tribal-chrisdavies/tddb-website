#!/usr/bin/env ruby
require 'prismic'
require 'json'
require 'time'  # json parsing????

class DataImporter
  def self.import()
    # Import data from Prismic.io using:
    # https://github.com/prismicio/ruby-kit
    puts ">> I'm gonna do stuff!"

    # Generate configuration settings
    config = JSON.parse('{
      "endpoint": "https://tddb-website.prismic.io/api",
      "links": {
        "case-studies": {
          "permalink": "/pages/:slug-:id/"
        }
      },
      "collections": {
        "case-studies": {
          "permalink": "/pages/:slug-:id/",
          "layout": "default.html"
        }
      }
    }')

    # Create Prismic API object
    @prismic_api ||= ::Prismic.api(config["endpoint"], {
      :access_token => config["access_token"],
      :cache => ::Prismic::BasicNullCache.new
    })

    # Get all data from Prismic
    begin
      puts ">> Trying to get data..."
      # @prismic_ref ||= prismic.refs[@config['prismic']['ref']] || prismic.master_ref
      response = @prismic_api.form('everything')
        .query()
        .submit(@prismic_api.master_ref)

      puts ">> Got some data:\n\n"
      puts "\n>> response.results: ("+response.results.length.to_s+")\n\n"
      puts response.results
      puts "\n"

      # File.open("./_data/prismic.json", "w") do |f|
      #   f.write( ::Prismic::JsonParser.response_parser(response) )
      # end

      res = {}
      response.results.each do |document|
        puts "\n>> document '"+document.type+"':'"+document.uid+"':\n\n"

        doc = {
          # :first_publication_date => document.first_publication_date,
          :fragments => extractFragments(document.fragments),
          # :href => document.href,
          # :id => document.id,
          # :last_publication_date => document.last_publication_date,
          # :slugs => document.slugs,
          # :tags => document.tags,
          # :type => document.type,
          :uid => document.uid
        }

        if defined? res[document.type]
          res[document.type] = []
        end
        res[document.type].push( doc )

        # File.open("./_data/prismic/"+document.uid+".json", "w") do |f|
        #   f.write( JSON.pretty_generate(doc) )
        # end
      end

      File.open("./_data/prismic.json", "w") do |f|
        f.write( JSON.pretty_generate(res) )
      end

      response.results.first
    rescue ::Prismic::SearchForm::FormSearchException
      puts ">> Didn't get any data!!"
      nil
    end
  end

  def self.extractFragments(fragments)
    frag = {}
    fragments.each do |name, fragment|
      frag[name] = extractFragment(fragment)
    end
    return frag
  end

  def self.extractFragment(fragment)
    if fragment.is_a?(::Prismic::Fragments::Text)
      return fragment.value
    elsif fragment.is_a?(::Prismic::Fragments::Image)
      return {
        :alt => fragment.main.alt,
        :copyright => fragment.main.copyright,
        :height => fragment.main.height,
        :link_to => fragment.main.link_to,
        :url => fragment.main.url,
        :width => fragment.main.width
      }
    elsif fragment.is_a?(::Prismic::Fragments::Group)
      docs = []
      fragment.each do |groupDocument|
        docs.push( extractFragment(groupDocument) )
      end
      return docs
    elsif fragment.is_a?(::Prismic::Fragments::GroupDocument)
      return extractFragments(fragment)
    end
    val = nil
    if defined? fragment.value
      val = fragment.value
    end
    return val
  end
end

DataImporter.import()
