# Upvoter

This is a Reddit-like news sharing website for the students of Omaha Code School. Anyone with login credentials can submit tutorials, articles, videos, etc that they think would be meaningful to current students or alumni. Like with Reddit, stories can be upvoted (or downvoted!) and rise/fall on the basis of those votes.

## Tech Stack

The site is built in Sinatra and stores data in a CSV file.


## Stories

Story #1:
The user visits the page, and the page displays the top 25 stories sorted by default.

Story #2:
The user clicks "Sign Up", and a modal becomes visible. The modal contains a form requesting a unique username, valid email address, and password.

Story #3:
The user clicks "Login", and a modal becomes visible. They type in their username and password into the related fields. If the password/username is incorrect, the user is given an error message and is prompted to try again. If the information is correct, the modal disappears, and the "Login | Sign up" section of the header becomes their name.

Story #4:
The user visits the page, they see a "featured" article that is highlighted and is at the top of the listed articles.

Story #5:
The user visits the page and sees an article they like. They click the "upvote" icon, and the upvote counter/score updates. The icon also becomes highlighted.

Story #6:
The user visits the page and sees an article they have previously upvoted. They have changed their mind and no longer like the article. They can click on the highlighted "upvote" icon, and their upvote will disappear. The counter will go down by 1.

Story #7:
When the user is logged in, they will see their username in the top right corner. Underneath the name, there will be a down-facing arrow that they can click on. They click on the arrow, and a drop-down menu will appear with a list of options they can interact with for their account.

Story #8:
The user visits the page and clicks the "new post" button. A modal will appear. If the user is not logged in, the modal will prompt them to log in. If they are logged in, the modal will contain a form that the user will fill out, with title of the post and post content.

Story #9:
When the user is finished filling out the "new post" form, and clicks submit, the modal will disappear. The page will refresh and will be automatically sorted by newest post, with the user's new post at the top.

Story #10:
When the user clicks the "sort" button, a drop-down menu of sorting options will become visible. When they select their sorting option, the page content will refresh to display posts in the user's selected order.

Story #11:
The user visits the page and scrolls to the bottom. There is a "next" button which they can click. The user clicks the "next" button, and the page refreshes with the following 25 posts available.

Story #12:
The user visits the page and scrolls to the bottom. There is a "previous" button which they can click. The user clicks the "previous" button, and the page refreshes with the previous 25 posts available.
