## Issue Tracker
### Create Issue Branch
A GitHub App/Action that automates the creation of issue branches (either automatically after assigning an issue or after commenting on an issue with a ChatOps command: /create-issue-branch or /cib).

For more information please refer to the following repo [create-issue-branch](https://github.com/robvanderleek/create-issue-branch) 
## Slack Notification 

Using github action, a fixed time interval of one month is used to check how long branches in the repository are inactive.

If a branch is inactive for more than 90 days, the user is notified via a Slack notification.

If the branch is inactive for more than 180 days, the user is notified that the branch will be closed. In this case, a pull request is first created and then closed again and the branch is deleted. This allows the user to restore the branch.
