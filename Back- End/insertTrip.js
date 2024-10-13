const { MongoClient } = require('mongodb');

const uri = 'mongodb+srv://TrekTempo_01:TrekTempo_01@cluster01.nojsq.mongodb.net/TrekTempo?retryWrites=true&w=majority&appName=Cluster01'; // replace with your MongoDB Atlas connection string
const client = new MongoClient(uri);

const trips = [
    {
        "starting_point": "Gampaha",
        "ending_point": "Colombo",
        "duration": 2,
        "budget": "low",
        "trip_person_type": "solo",
        "trip_type": "historical",
        "places_to_visit": [
            {
                "name": "Diyawanna Oya",
                "description": "A beautiful park.",
                "weather": "Sunny"
            }
        ],
        "accommodation": {
            "hotel_name": "Gampaha Hotel",
            "price_per_night": 70
        },
        "restaurants": [
            {
                "name": "Local Cuisine Restaurant",
                "cuisine": "Sri Lankan"
            }
        ]
    },
    // Add more trip objects here...
    {
        "starting_point": "Kalutara",
        "ending_point": "Colombo",
        "duration": 2,
        "budget": "medium",
        "trip_person_type": "friends",
        "trip_type": "adventure",
        "places_to_visit": [
            {
                "name": "Kalutara Beach",
                "description": "Known for its beautiful coastline.",
                "weather": "Sunny"
            }
        ],
        "accommodation": {
            "hotel_name": "Kalutara Hotel",
            "price_per_night": 90
        },
        "restaurants": [
            {
                "name": "The Beach Restaurant",
                "cuisine": "Seafood"
            }
        ]
    }
];

async function run() {
    try {
        await client.connect();
        const database = client.db('TrekTempo');
        const collection = database.collection('trips');
        const result = await collection.insertMany(trips);
        console.log(`${result.insertedCount} trips were inserted.`);
    } finally {
        await client.close();
    }
}

run().catch(console.dir);
