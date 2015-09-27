loan1 = Loan.create(title: "Urban Bees",
                    description: "Buy local Denver honey.",
                    price: 50,
                    avatar_file_name: "http://i.dailymail.co.uk/i/pix/2011/08/01/article-2021108-0D40723300000578-13_634x383.jpg")

loan2 = Loan.create(title: "Kitten Mittens",
                    description: "Keep your kittens cozy. These mittens are handcrafted by a Capitol Hill artisan who anticipates being able to repay the loan within 6 months of starting her business. She already has a proven customer base.",
                    price: 25,
                    avatar_file_name: "http://pitt.edu/~sak162/kitten.jpg")

loan3 = Loan.create(title: "Bike Bus",
                    description: "We'll bring our shop to you.",
                    price: 100,
                    avatar_file_name: "http://urbansimplicty.files.wordpress.com/2009/06/bikebus.jpg")

category1 = Category.create(name: "Crafts")

category2 = Category.create(name: "Agriculture")

category3 = Category.create(name: "Transportation")

category1.loans << loan2
category2.loans << loan1
category3.loans << loan3
