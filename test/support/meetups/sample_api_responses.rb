require 'ostruct'

def group_endpoint_response
	response = build_response #Calls build_response, current sends nothing so it defaults to 200
	response.parsed_response = group_endpoint_parsed_response #Where does this come from?
	response #This is the entire response as returned from Meetup
end

def events_endpoint_response
	response = build_response
	response.parsed_response = events_endpoint_parsed_response
	response
end

def build_response(code: 200)
	response_struct = OpenStruct.new
	response_struct.code = code
	response_struct
end

def events_endpoint_parsed_response
end


#Meetup V3. Hits endpoint /groups.  This is the response.parsed_response
def group_endpoint_parsed_response
	[
		{
			"id"=>26005124,
		  "name"=>"MilSpouseCoders Guam",
		  "description"=>
		   "<p>Code &amp; Coffee&nbsp;is a monthly opportunity for you to practice your skills, meet new friends, and get help if you need it. Bring your laptop, your recent projects, and your programming problems!</p>\n<p>All are welcome regardless of gender or skill level. If you're a beginner, we'll be right there to help you work through your questions as needed.</p>\n<p>Code &amp; Coffee events are relaxed and informal, and are intended as a way for our community to work and play together while providing each other with ongoing support and feedback.</p>",
		  "lat"=>13.539999961853027,
		  "lon"=>144.8800048828125,
		  "city"=>"Yigo",
		  "country"=>"Guam",
		  "urlname"=>"MilSpouseCoders-Guam",
		  "member_count"=>5,
		  "average_age"=>40.0,
		  "founded_date"=>1506017696000,
		  "pro_join_date"=>1506019157000,
		  "past_events"=>0,
		  "upcoming_events"=>0,
		  "past_rsvps"=>0,
		  "rsvps_per_event"=>0.0,
		  "repeat_rsvpers"=>0,
		  "topics"=>
		   [{"id"=>659, "name"=>"Web Design", "urlkey"=>"webdesign", "lang"=>"en_US"},
		    {"id"=>1863, "name"=>"Military Families and Friends", "urlkey"=>"mff", "lang"=>"en_US"},
		    {"id"=>3833, "name"=>"Software Development", "urlkey"=>"softwaredev", "lang"=>"en_US"},
		    {"id"=>10209, "name"=>"Web Technology", "urlkey"=>"web", "lang"=>"en_US"},
		    {"id"=>15582, "name"=>"Web Development", "urlkey"=>"web-development", "lang"=>"en_US"},
		    {"id"=>15735, "name"=>"Military Spouses", "urlkey"=>"military-spouses", "lang"=>"en_US"},
		    {"id"=>91416, "name"=>"Military and Veterans", "urlkey"=>"military-and-veterans", "lang"=>"en_US"}],
		  "category"=>[{"id"=>34, "name"=>"Tech", "shortname"=>"tech", "sort_name"=>"Tech"}],
		  "gender_unknown"=>0.0,
		  "gender_female"=>0.33329999446868896,
		  "gender_male"=>0.666700005531311,
		  "gender_other"=>0.0,
		  "organizers"=>
		   [{"name"=>"Toanh Tran", "member_id"=>217428519, "permission"=>"coorganizer"},
		    {"name"=>"Milly Q", "member_id"=>237098996, "permission"=>"coorganizer"},
		    {"name"=>"Conrad Hollomon", "member_id"=>194532776, "permission"=>"organizer"}],
		  "status"=>"Active",
		  "organizer_photo"=>
		   {"id"=>262534246,
		    "highres_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/highres_262534246.jpeg",
		    "photo_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/member_262534246.jpeg",
		    "thumb_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/thumb_262534246.jpeg",
		    "type"=>"member",
		    "base_url"=>"https://secure.meetupstatic.com"},
		  "group_photo"=>
		   {"id"=>464785690,
		    "highres_link"=>"https://secure.meetupstatic.com/photos/event/6/4/5/a/highres_464785690.jpeg",
		    "photo_link"=>"https://secure.meetupstatic.com/photos/event/6/4/5/a/600_464785690.jpeg",
		    "thumb_link"=>"https://secure.meetupstatic.com/photos/event/6/4/5/a/thumb_464785690.jpeg",
		    "type"=>"event",
		    "base_url"=>"https://secure.meetupstatic.com"}},
		 {"id"=>26005046,
		  "name"=>"MilSpouseCoders NOVA (Northern Virginia)",
		  "description"=>
		   "<p>All are welcome regardless of gender or skill level.&nbsp;<span>Meet new people and learn about tech. This meetup is great for military spouses and their families who want to learn about coding. Great for beginners with little to no experience.&nbsp;</span><span>If you're a beginner, we'll be right there to help you work through your questions as needed.</span></p>\n<p><span>Code &amp; Coffee events are relaxed and </span>informal,<span> and are intended as a way for our community to work and play together while providing each other with ongoing support and feedback.</span><br></p>\n<br>",
		  "lat"=>38.81999969482422,
		  "lon"=>-77.05999755859375,
		  "city"=>"Alexandria",
		  "state"=>"VA",
		  "country"=>"USA",
		  "urlname"=>"MilSpouseCoders-NOVA-Northern-Virginia",
		  "member_count"=>10,
		  "average_age"=>44.5,
		  "founded_date"=>1506017122000,
		  "pro_join_date"=>1506019149000,
		  "last_event"=>1506526200000,
		  "next_event"=>1507732200000,
		  "past_events"=>1,
		  "upcoming_events"=>1,
		  "past_rsvps"=>1,
		  "rsvps_per_event"=>1.0,
		  "repeat_rsvpers"=>1,
		  "topics"=>
		   [{"id"=>563, "name"=>"Open Source", "urlkey"=>"opensource", "lang"=>"en_US"},
		    {"id"=>659, "name"=>"Web Design", "urlkey"=>"webdesign", "lang"=>"en_US"},
		    {"id"=>3833, "name"=>"Software Development", "urlkey"=>"softwaredev", "lang"=>"en_US"},
		    {"id"=>10209, "name"=>"Web Technology", "urlkey"=>"web", "lang"=>"en_US"},
		    {"id"=>15582, "name"=>"Web Development", "urlkey"=>"web-development", "lang"=>"en_US"},
		    {"id"=>15735, "name"=>"Military Spouses", "urlkey"=>"military-spouses", "lang"=>"en_US"},
		    {"id"=>18176, "name"=>"Military", "urlkey"=>"military", "lang"=>"en_US"},
		    {"id"=>48471, "name"=>"Computer programming", "urlkey"=>"computer-programming", "lang"=>"en_US"},
		    {"id"=>91416, "name"=>"Military and Veterans", "urlkey"=>"military-and-veterans", "lang"=>"en_US"}],
		  "category"=>[{"id"=>34, "name"=>"Tech", "shortname"=>"tech", "sort_name"=>"Tech"}],
		  "gender_unknown"=>0.0,
		  "gender_female"=>0.666700005531311,
		  "gender_male"=>0.33329999446868896,
		  "gender_other"=>0.0,
		  "organizers"=>
		   [{"name"=>"Toanh Tran", "member_id"=>217428519, "permission"=>"coorganizer"},
		    {"name"=>"Mercedes Welch", "member_id"=>237107111, "permission"=>"coorganizer"},
		    {"name"=>"Conrad Hollomon", "member_id"=>194532776, "permission"=>"organizer"}],
		  "status"=>"Active",
		  "organizer_photo"=>
		   {"id"=>262534246,
		    "highres_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/highres_262534246.jpeg",
		    "photo_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/member_262534246.jpeg",
		    "thumb_link"=>"https://secure.meetupstatic.com/photos/member/8/5/c/6/thumb_262534246.jpeg",
		    "type"=>"member",
		    "base_url"=>"https://secure.meetupstatic.com"},
		  "group_photo"=>
		   {"id"=>464785899,
		    "highres_link"=>"https://secure.meetupstatic.com/photos/event/6/5/2/b/highres_464785899.jpeg",
		    "photo_link"=>"https://secure.meetupstatic.com/photos/event/6/5/2/b/600_464785899.jpeg",
		    "thumb_link"=>"https://secure.meetupstatic.com/photos/event/6/5/2/b/thumb_464785899.jpeg",
		    "type"=>"event",
		    "base_url"=>"https://secure.meetupstatic.com"}
		    }
		  ]
		end
