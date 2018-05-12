require 'ostruct'

def group_endpoint_response
  response = build_response #Calls build_response, current sends nothing so it defaults to 200
  response.parsed_response = group_endpoint_parsed_response #Where does this come from?
  response #This is the entire response as returned from Meetup
end

def event_endpoint_response
  response = build_response
  response.parsed_response = event_endpoint_parsed_response
  response
end

def build_response(code = 200)
  response_struct = OpenStruct.new
  response_struct.code = code
  response_struct
end

#Meetup V3 /events endpoint
#Data was retrieved from calling in console Meetup.new.get_events_for("Operation-Code-Hampton_Roads")
#Documentation: https://secure.meetup.com/meetup_api/console/?path=/:urlname/events
#There are 4 events. For testing purposes the last event does not have a venue field. If venue is not entered
#by Meetup organizer it does not exist in the response, and we do not save the event to the database.
def event_endpoint_parsed_response
  [
    {
      'created' => 1503597602000,
      'id' => '242801028',
      'name' => 'Come Learn To Code!',
      'status' => 'upcoming',
      'time' => 1508454000000,
      'updated' => 1503597602000,
      'utc_offset' => -14400000,
      'waitlist_count' => 0,
      'yes_rsvp_count' => 28,
      'venue' =>
       {'id' => 24628300,
        'name' => '1701',
        'lat' => 36.844764709472656,
        'lon' => -75.97899627685547,
        'repinned' => false,
        'address_1' => '1701 Baltic Avenue',
        'city' => 'Virginia Beach',
        'country' => 'us',
        'localized_country_name' => 'USA',
        'zip' => '',
        'state' => 'VA'},
      'group' =>
       {'created' => 1483543375000,
        'name' => 'Operation Code: Hampton Roads',
        'id' => 21767819,
        'join_mode' => 'open',
        'lat' => 36.900001525878906,
        'lon' => -76.20999908447266,
        'urlname' => 'Operation-Code-Hampton-Roads',
        'who' => 'coders',
        'localized_location' => 'Norfolk, VA',
        'region' => 'en_US'},
      'link' => 'https://www.meetup.com/Operation-Code-Hampton-Roads/events/242801028/',
      'manual_attendance_count' => 0,
      'description' =>
       "<p>Operation Code is an initiative to introduce veterans to the software development community. In this group, we will work together to design a website for aggregating veteran resources.</p> <p>No experience is necessary to join. In fact, we encourage those who want to learn how to code to join us! If you are a developer and would like to provide mentorship, we would greatly appreciate your participation, as well.</p> <p>In this meetup, we will discuss the progress that we've made and the next items on our list to complete. When the team is clear about the objectives, we will break into teams for pair programming and continue to build our website.</p> <p>Feel free to contact Larry Burris if you have any questions.</p> ",
      'visibility' => 'public'
    },
    {
      'created' => 1506360598000,
      'duration' => 7200000,
      'id' => '243654482',
      'name' => 'Come Learn to Code!',
      'status' => 'upcoming',
      'time' => 1510875000000,
      'updated' => 1506360640000,
      'utc_offset' => -18000000,
      'waitlist_count' => 0,
      'yes_rsvp_count' => 3,
      'venue' =>
       {'id' => 24975001,
        'name' => 'ODU Innovation Center',
        'lat' => 36.8532600402832,
        'lon' => -76.29104614257812,
        'repinned' => false,
        'address_1' => '501 Boush St',
        'city' => 'Norfolk',
        'country' => 'us',
        'localized_country_name' => 'USA',
        'zip' => '23510',
        'state' => 'VA'},
      'group' =>
       {'created' => 1483543375000,
        'name' => 'Operation Code: Hampton Roads',
        'id' => 21767819,
        'join_mode' => 'open',
        'lat' => 36.900001525878906,
        'lon' => -76.20999908447266,
        'urlname' => 'Operation-Code-Hampton-Roads',
        'who' => 'coders',
        'localized_location' => 'Norfolk, VA',
        'region' => 'en_US'},
      'link' => 'https://www.meetup.com/Operation-Code-Hampton-Roads/events/243654482/',
      'description' =>
       "<p>Operation Code is an initiative to introduce veterans to the software development community. In this group, we will work together to design a website for aggregating veteran resources.</p> <p>No experience is necessary to join. In fact, we encourage those who want to learn how to code to join us! If you are a developer and would like to provide mentorship, we would greatly appreciate your participation, as well.</p> <p>In this meetup, we will discuss the progress that we've made and the next items on our list to complete. When the team is clear about the objectives, we will break into teams for pair programming and continue to build our website.</p> <p>Feel free to contact Larry Burris if you have any questions.</p> ",
      'visibility' => 'public'
    },
    {
      'created' => 1506361286000,
      'duration' => 7200000,
      'id' => '243655170',
      'name' => 'Come Learn To Code!',
      'status' => 'upcoming',
      'time' => 1513899000000,
      'updated' => 1506361286000,
      'utc_offset' => -18000000,
      'waitlist_count' => 0,
      'yes_rsvp_count' => 2,
      'venue' =>
       {'id' => 24628300,
        'name' => '1701',
        'lat' => 36.844764709472656,
        'lon' => -75.97899627685547,
        'repinned' => false,
        'address_1' => '1701 Baltic Avenue',
        'city' => 'Virginia Beach',
        'country' => 'us',
        'localized_country_name' => 'USA',
        'zip' => '',
        'state' => 'VA'},
      'group' =>
       {'created' => 1483543375000,
        'name' => 'Operation Code: Hampton Roads',
        'id' => 21767819,
        'join_mode' => 'open',
        'lat' => 36.900001525878906,
        'lon' => -76.20999908447266,
        'urlname' => 'Operation-Code-Hampton-Roads',
        'who' => 'coders',
        'localized_location' => 'Norfolk, VA',
        'region' => 'en_US'},
      'link' => 'https://www.meetup.com/Operation-Code-Hampton-Roads/events/243655170/',
      'description' =>
       "<p>Operation Code is an initiative to introduce veterans to the software development community. In this group, we will work together to design a website for aggregating veteran resources.</p> <p>No experience is necessary to join. In fact, we encourage those who want to learn how to code to join us! If you are a developer and would like to provide mentorship, we would greatly appreciate your participation, as well.</p> <p>In this meetup, we will discuss the progress that we've made and the next items on our list to complete. When the team is clear about the objectives, we will break into teams for pair programming and continue to build our website.</p> <p>Feel free to contact Larry Burris if you have any questions.</p> ",
      'visibility' => 'public'
    },
    {
      'created' => 1506361383000,
      'duration' => 7200000,
      'id' => '243655210',
      'name' => 'Come learn to code!',
      'status' => 'upcoming',
      'time' => 1516318200000,
      'updated' => 1506361383000,
      'utc_offset' => -18000000,
      'waitlist_count' => 0,
      'yes_rsvp_count' => 2,
      # "venue"=>
      #  {"id"=>24975001,
      #   "name"=>"ODU Innovation Center",
      #   "lat"=>36.8532600402832,
      #   "lon"=>-76.29104614257812,
      #   "repinned"=>false,
      #   "address_1"=>"501 Boush St",
      #   "city"=>"Norfolk",
      #   "country"=>"us",
      #   "localized_country_name"=>"USA",
      #   "zip"=>"23510",
      #   "state"=>"VA"},
      'group' =>
       {'created' => 1483543375000,
        'name' => 'Operation Code: Hampton Roads',
        'id' => 21767819,
        'join_mode' => 'open',
        'lat' => 36.900001525878906,
        'lon' => -76.20999908447266,
        'urlname' => 'Operation-Code-Hampton-Roads',
        'who' => 'coders',
        'localized_location' => 'Norfolk, VA',
        'region' => 'en_US'},
      'link' => 'https://www.meetup.com/Operation-Code-Hampton-Roads/events/243655210/',
      'description' =>
       "<p>Operation Code is an initiative to introduce veterans to the software development community. In this group, we will work together to design a website for aggregating veteran resources.</p> <p>No experience is necessary to join. In fact, we encourage those who want to learn how to code to join us! If you are a developer and would like to provide mentorship, we would greatly appreciate your participation, as well.</p> <p>In this meetup, we will discuss the progress that we've made and the next items on our list to complete. When the team is clear about the objectives, we will break into teams for pair programming and continue to build our website.</p> <p>Feel free to contact Larry Burris if you have any questions.</p> ",
      'visibility' => 'public'
    }
  ]
end

#Meetup V3 /groups endpoint (PRO only)
#Data was retried from calling in console Meetup.new.operationcode_data and grabbing the Operation-Code-Hampton_Roads group
#NOTE: The /events data is based on this group only!  This data cannot be changed without also updating the sample events data
#In browser: https://api.meetup.com/pro/operationcode/groups?key=apikey&sign=true
def group_endpoint_parsed_response
  [
    {
      "id": 21767819,
      "name": 'Operation Code: Hampton Roads',
      "description": "<p>Operation Code is a nonprofit devoted to helping the military community learn software development, enter the tech industry, and code the future!</p> \n<p>We're looking to bring together aspiring developers of all levels and backgrounds, from learning-from-scratch to senior engineers, to help each other learn more about coding and building great things.</p>",
      "lat": 36.900001525878906,
      "lon": -76.20999908447266,
      "city": 'Norfolk',
      "state": 'VA',
      "country": 'USA',
      "urlname": 'Operation-Code-Hampton-Roads',
      "member_count": 341,
      "average_age": 31.79170036315918,
      "founded_date": 1483543375000,
      "pro_join_date": 1483543431000,
      "last_event": 1506171600000,
      "next_event": 1508454000000,
      "past_events": 9,
      "upcoming_events": 4,
      "past_rsvps": 179,
      "rsvps_per_event": 19.888900756835938,
      "repeat_rsvpers": 38,
      "topics": [
        {
          "id": 308,
          "name": 'Veterans',
          "urlkey": 'vets',
          "lang": 'en_US'
        },
        {
          "id": 563,
          "name": 'Open Source',
          "urlkey": 'opensource',
          "lang": 'en_US'
        },
        {
          "id": 1863,
          "name": 'Military Families and Friends',
          "urlkey": 'mff',
          "lang": 'en_US'
        },
        {
          "id": 3833,
          "name": 'Software Development',
          "urlkey": 'softwaredev',
          "lang": 'en_US'
        },
        {
          "id": 15582,
          "name": 'Web Development',
          "urlkey": 'web-development',
          "lang": 'en_US'
        },
        {
          "id": 17836,
          "name": 'Support our military',
          "urlkey": 'support-our-military',
          "lang": 'en_US'
        },
        {
          "id": 25610,
          "name": 'Veterans Service Organizations',
          "urlkey": 'veterans-service-organizations',
          "lang": 'en_US'
        },
        {
          "id": 48471,
          "name": 'Computer programming',
          "urlkey": 'computer-programming',
          "lang": 'en_US'
        },
        {
          "id": 90286,
          "name": 'Social Coding',
          "urlkey": 'social-coding',
          "lang": 'en_US'
        },
        {
          "id": 725122,
          "name": 'learn to code',
          "urlkey": 'learn-to-code',
          "lang": 'en_US'
        }
      ],
      "category": [
        {
          "id": 34,
          "name": 'Tech',
          "shortname": 'tech',
          "sort_name": 'Tech'
        }
      ],
      "gender_unknown": 0.0284000001847744,
      "gender_female": 0.30140000581741333,
      "gender_male": 0.663100004196167,
      "gender_other": 0.0071000000461936,
      "organizers": [
        {
          "name": 'matt',
          "member_id": 62995492,
          "permission": 'coorganizer'
        },
        {
          "name": 'Larry Burris',
          "member_id": 204630218,
          "permission": 'coorganizer'
        },
        {
          "name": 'Conrad Hollomon',
          "member_id": 194532776,
          "permission": 'organizer'
        }
      ],
      "status": 'Active',
      "organizer_photo": {
        "id": 262534246,
        "highres_link": 'https://secure.meetupstatic.com/photos/member/8/5/c/6/highres_262534246.jpeg',
        "photo_link": 'https://secure.meetupstatic.com/photos/member/8/5/c/6/member_262534246.jpeg',
        "thumb_link": 'https://secure.meetupstatic.com/photos/member/8/5/c/6/thumb_262534246.jpeg',
        "type": 'member',
        "base_url": 'https://secure.meetupstatic.com'
      },
      "group_photo": {
        "id": 457308404,
        "highres_link": 'https://secure.meetupstatic.com/photos/event/b/d/1/4/highres_457308404.jpeg',
        "photo_link": 'https://secure.meetupstatic.com/photos/event/b/d/1/4/600_457308404.jpeg',
        "thumb_link": 'https://secure.meetupstatic.com/photos/event/b/d/1/4/thumb_457308404.jpeg',
        "type": 'event',
        "base_url": 'https://secure.meetupstatic.com'
      }
    }
  ].as_json
end
