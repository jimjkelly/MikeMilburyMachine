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
    db = get_connection
    @collection = db.collection(COLLECTION)
    return MongoHash.find(@collection)
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
