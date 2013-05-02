require 'uri'
require 'mongo'
require 'mongo_hash'

COLLECTION = 'lawls'

def addlawl(quote, douche, link, ovi)
    db = get_connection

    @collection = db.collection(COLLECTION)
    mh = MongoHash.new(@collection)

    mh[MongoHash.find(@collection).length + 1] = {
        'quote' => quote,
        'douche' => douche,
        'link' => link,
        'ovi' => ovi
    }
    mh.save
end 

def getlawls
    #db = get_connection
    #@collection = db.collection(COLLECTION)
    #return MongoHash.find(@collection)
    return [{'quote' => 'If it looks like a dog, barks like a dog, it is a dog.  Also, I have a really big cock.  Like, gargantuan.',
             'douche' => 'Mike Milbury',
             'link' => 'http://www.cbc.ca/sports/hockey/hnicplayoff/2008/04/ovechkins_gone_to_the_dogs_and.html',
             'ovi' => 'hlp=8471214&event=WSH426'},
            {'quote' => 'I have Crosby\'s dick firmly planted in my mouth, so really anything I say is probably suspect.  But I won\'t let that stop me from telling you what a homer I am for Canada.',
             'douche' => 'Don Cherry',
             'link' => 'http://www.cbc.ca/sports/hockey/hnicplayoff/2008/04/ovechkins_gone_to_the_dogs_and.html',
             'ovi' => 'hlp=8471214&event=WSH426'}]
end

def get_connection

    return @db_connection if @db_connection
    
    if ENV['MONGO_URL_DEV']
        dburl = ENV['MONGO_URL_DEV']
    else
        dburl = ENV['MONGOHQ_URL']
    end
    
    db = URI.parse(dburl)
    db_name = db.path.gsub(/^\//, '')
    @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
    @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
    @db_connection
end
