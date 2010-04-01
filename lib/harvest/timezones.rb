# shamelessly ripped from Rails: http://github.com/rails/rails/blob/master/activesupport/lib/active_support/values/time_zone.rb

module Harvest
  module Timezones
    MAPPING = {
        "pacific/midway"                  =>   "International Date Line West",
        "pacific/midway"                  =>   "Midway Island",
        "pacific/pago_pago"               =>   "Samoa",
        "pacific/honolulu"                =>   "Hawaii",
        "america/juneau"                  =>   "Alaska",
        "america/los_angeles"             =>   "Pacific Time (US & Canada)",
        "america/tijuana"                 =>   "Tijuana",
        "america/denver"                  =>   "Mountain Time (US & Canada)",
        "america/phoenix"                 =>   "Arizona",
        "america/chihuahua"               =>   "Chihuahua",
        "america/mazatlan"                =>   "Mazatlan",
        "america/chicago"                 =>   "Central Time (US & Canada)",
        "america/regina"                  =>   "Saskatchewan",
        "america/mexico_city"             =>   "Guadalajara",
        "america/mexico_city"             =>   "Mexico City",
        "america/monterrey"               =>   "Monterrey",
        "america/guatemala"               =>   "Central America",
        "america/new_york"                =>   "Eastern Time (US & Canada)",
        "america/indiana/indianapolis"    =>   "Indiana (East)",
        "america/bogota"                  =>   "Bogota",
        "america/lima"                    =>   "Lima",
        "america/lima"                    =>   "Quito",
        "america/halifax"                 =>   "Atlantic Time (Canada)",
        "america/caracas"                 =>   "Caracas",
        "america/la_paz"                  =>   "La Paz",
        "america/santiago"                =>   "Santiago",
        "america/st_johns"                =>   "Newfoundland",
        "america/sao_paulo"               =>   "Brasilia",
        "america/argentina/buenos_aires"  =>   "Buenos Aires",
        "america/argentina/san_juan"      =>   "Georgetown",
        "america/godthab"                 =>   "Greenland",
        "atlantic/south_georgia"          =>   "Mid-Atlantic",
        "atlantic/azores"                 =>   "Azores",
        "atlantic/cape_verde"             =>   "Cape Verde Is.",
        "europe/dublin"                   =>   "Dublin",
        "europe/dublin"                   =>   "Edinburgh",
        "europe/lisbon"                   =>   "Lisbon",
        "europe/london"                   =>   "London",
        "africa/casablanca"               =>   "Casablanca",
        "africa/monrovia"                 =>   "Monrovia",
        "etc/utc"                         =>   "UTC",
        "europe/belgrade"                 =>   "Belgrade",
        "europe/bratislava"               =>   "Bratislava",
        "europe/budapest"                 =>   "Budapest",
        "europe/ljubljana"                =>   "Ljubljana",
        "europe/prague"                   =>   "Prague",
        "europe/sarajevo"                 =>   "Sarajevo",
        "europe/skopje"                   =>   "Skopje",
        "europe/warsaw"                   =>   "Warsaw",
        "europe/zagreb"                   =>   "Zagreb",
        "europe/brussels"                 =>   "Brussels",
        "europe/copenhagen"               =>   "Copenhagen",
        "europe/madrid"                   =>   "Madrid",
        "europe/paris"                    =>   "Paris",
        "europe/amsterdam"                =>   "Amsterdam",
        "europe/berlin"                   =>   "Berlin",
        "europe/berlin"                   =>   "Bern",
        "europe/rome"                     =>   "Rome",
        "europe/stockholm"                =>   "Stockholm",
        "europe/vienna"                   =>   "Vienna",
        "africa/algiers"                  =>   "West Central Africa",
        "europe/bucharest"                =>   "Bucharest",
        "africa/cairo"                    =>   "Cairo",
        "europe/helsinki"                 =>   "Helsinki",
        "europe/kiev"                     =>   "Kyev",
        "europe/riga"                     =>   "Riga",
        "europe/sofia"                    =>   "Sofia",
        "europe/tallinn"                  =>   "Tallinn",
        "europe/vilnius"                  =>   "Vilnius",
        "europe/athens"                   =>   "Athens",
        "europe/istanbul"                 =>   "Istanbul",
        "europe/minsk"                    =>   "Minsk",
        "asia/jerusalem"                  =>   "Jerusalem",
        "africa/harare"                   =>   "Harare",
        "africa/johannesburg"             =>   "Pretoria",
        "europe/moscow"                   =>   "Moscow",
        "europe/moscow"                   =>   "St. Petersburg",
        "europe/moscow"                   =>   "Volgograd",
        "asia/kuwait"                     =>   "Kuwait",
        "asia/riyadh"                     =>   "Riyadh",
        "africa/nairobi"                  =>   "Nairobi",
        "asia/baghdad"                    =>   "Baghdad",
        "asia/tehran"                     =>   "Tehran",
        "asia/muscat"                     =>   "Abu Dhabi",
        "asia/muscat"                     =>   "Muscat",
        "asia/baku"                       =>   "Baku",
        "asia/tbilisi"                    =>   "Tbilisi",
        "asia/yerevan"                    =>   "Yerevan",
        "asia/kabul"                      =>   "Kabul",
        "asia/yekaterinburg"              =>   "Ekaterinburg",
        "asia/karachi"                    =>   "Islamabad",
        "asia/karachi"                    =>   "Karachi",
        "asia/tashkent"                   =>   "Tashkent",
        "asia/kolkata"                    =>   "Chennai",
        "asia/kolkata"                    =>   "Kolkata",
        "asia/kolkata"                    =>   "Mumbai",
        "asia/kolkata"                    =>   "New Delhi",
        "asia/katmandu"                   =>   "Kathmandu",
        "asia/dhaka"                      =>   "Astana",
        "asia/dhaka"                      =>   "Dhaka",
        "asia/colombo"                    =>   "Sri Jayawardenepura",
        "asia/almaty"                     =>   "Almaty",
        "asia/novosibirsk"                =>   "Novosibirsk",
        "asia/rangoon"                    =>   "Rangoon",
        "asia/bangkok"                    =>   "Bangkok",
        "asia/bangkok"                    =>   "Hanoi",
        "asia/jakarta"                    =>   "Jakarta",
        "asia/krasnoyarsk"                =>   "Krasnoyarsk",
        "asia/shanghai"                   =>   "Beijing",
        "asia/chongqing"                  =>   "Chongqing",
        "asia/hong_kong"                  =>   "Hong Kong",
        "asia/urumqi"                     =>   "Urumqi",
        "asia/kuala_lumpur"               =>   "Kuala Lumpur",
        "asia/singapore"                  =>   "Singapore",
        "asia/taipei"                     =>   "Taipei",
        "australia/perth"                 =>   "Perth",
        "asia/irkutsk"                    =>   "Irkutsk",
        "asia/ulaanbaatar"                =>   "Ulaan Bataar",
        "asia/seoul"                      =>   "Seoul",
        "asia/tokyo"                      =>   "Osaka",
        "asia/tokyo"                      =>   "Sapporo",
        "asia/tokyo"                      =>   "Tokyo",
        "asia/yakutsk"                    =>   "Yakutsk",
        "australia/darwin"                =>   "Darwin",
        "australia/adelaide"              =>   "Adelaide",
        "australia/melbourne"             =>   "Canberra",
        "australia/melbourne"             =>   "Melbourne",
        "australia/sydney"                =>   "Sydney",
        "australia/brisbane"              =>   "Brisbane",
        "australia/hobart"                =>   "Hobart",
        "asia/vladivostok"                =>   "Vladivostok",
        "pacific/guam"                    =>   "Guam",
        "pacific/port_moresby"            =>   "Port Moresby",
        "asia/magadan"                    =>   "Magadan",
        "asia/magadan"                    =>   "Solomon Is.",
        "pacific/noumea"                  =>   "New Caledonia",
        "pacific/fiji"                    =>   "Fiji",
        "asia/kamchatka"                  =>   "Kamchatka",
        "pacific/majuro"                  =>   "Marshall Is.",
        "pacific/auckland"                =>   "Auckland",
        "pacific/auckland"                =>   "Wellington",
        "pacific/tongatapu"               =>   "Nuku'alofa"
      }
  end
end