loan1 = Loan.create(title: "Urban Bees",
                    description: "Buy local Denver honey.",
                    price: 50,
                    avatar_file_name: "https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/Fork-Beekeeping.jpg")

loan2 = Loan.create(title: "Kitten Mittens",
                    description: "Keep your kittens cozy. These mittens are handcrafted by a Capitol Hill artisan who anticipates being able to repay the loan within 6 months of starting her business. She already has a proven customer base.",
                    price: 25,
                    avatar_file_name: "https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/3_Kittens_Playing_in_the_Garden.jpg")

loan3 = Loan.create(title: "Bike Bus",
                    description: "We'll bring our shop to you.",
                    price: 100,
                    avatar_file_name: "https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/Hilltop_Bicycles_Summit_NJ.JPG")

category1 = Category.create(name: "Crafts")

category2 = Category.create(name: "Agriculture")

category3 = Category.create(name: "Transportation")

category1.loans << loan2
category2.loans << loan1
category3.loans << loan3
