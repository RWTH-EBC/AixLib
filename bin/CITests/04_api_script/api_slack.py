import re
import json
import requests
from datetime import datetime
from datetime import date
import argparse
import time
import os

class Slack_Notification(object):

    def __init__(self, github_token, slack_token, github_repo, base_branch):
        self.slack_token = slack_token
        self.github_token = github_token
        self.github_repo = github_repo
        self.base_branch = base_branch
        self.url = f'https://api.github.com/repos/{github_repo}/branches'

    def _get_data(self, branch):  # date of last commit
        branch_url = self.url + "/" + branch
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", branch_url, headers=headers, data=payload)
        reponse_text = response.json()
        commit = reponse_text["commit"]

        data_commit = commit["commit"]
        author_commit = data_commit["author"]
        try:
            author_login = commit["author"]
            login_name = author_login["login"]
        except TypeError:
            login_name = author_commit["name"]
        return author_commit, login_name

    def _get_branches(self):  # get a list of branches in repo
        try:
            url = f'{self.url}?per_page=100'
            payload={}
            headers = {
                'Authorization': 'Bearer ' + self.github_token,
                'Content-Type': 'application/json'
            }
            response = requests.request("GET", url, headers=headers, data=payload)
            text = response.json()
            branch_list = []
            for dic in text:
                branch_list.append(dic["name"])
            return branch_list
        except requests.ConnectionError as e:
            print(e)

    def _local_time(self):
        l_time = date.today()
        return l_time

    def _get_time(self, commit):
        date = commit["date"]
        date = date[:date.find("T")]
        time = datetime.strptime(date, '%Y-%m-%d').date()
        return time

    def _get_name(self, commit):
        name = commit["name"]
        return name

    def _get_name_mail(self, commit):
        email = commit["email"]
        return email

    def _get_user_list(self):
        url = "https://slack.com/api/users.list"
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.slack_token
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        slack_user_list = response.json()
        return slack_user_list

    def _get_slack_mail(self, slack_user_list):
        slack_mail_id = {}
        member_array = slack_user_list["members"]
        for member in member_array:
            profile = member["profile"]
            slack_email = profile.get("email")
            id = member.get("id")
            if slack_email is None:
                continue
            slack_mail_id[slack_email] = id
        return slack_mail_id

    def _get_slack_id(self, github_mail, slack_mail_id, name):
        for slack_email in slack_mail_id:
            if github_mail.find("@rwth-aachen.de") > -1:
                if github_mail.replace("@", "@eonerc.").lower() == slack_email.lower():
                    #print(f'Slack Email: {slack_email}')
                    id = slack_mail_id[slack_email]
                    #print(f'Slack id: {id}')
                    return id
        for slack_email in slack_mail_id:
            if github_mail.lower() == slack_email.lower():
                #print(f'Slack Email: {slack_email}')
                id = slack_mail_id[slack_email]
                #print(f'Slack id: {id}')
                return id
        for slack_email in slack_mail_id:
            if github_mail[:github_mail.rfind("@")].lower() == slack_email[:slack_email.rfind("@")].lower():
                #print(f'Slack Email: {slack_email}')
                id = slack_mail_id[slack_email]
                #print(f'Slack id: {id}')
                return id
        print(f'Cannot find Slack ID of user: {name} \nSend Slack message to channel fg-modelica')
        id = "CBZ9FJH27"
        #id = "C02NXDEL1GD"
        print(f'Slack channel fg-modelica-id: {id}')
        return id


    def _delete_branch(self, branch):
        url = f'https://api.github.com/repos/{self.github_repo}/git/refs/heads/{branch}'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token
        }
        response = requests.request("DELETE", url, headers=headers, data=payload)


    def _get_pr_number(self, branch):
        url = f'https://api.github.com/repos/{self.github_repo}/pulls'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        pull_request_json = response.json()
        for pull in pull_request_json:
            name = pull["head"].get("ref")
            if name == branch:
                return pull["number"]

    def _close_pr(self, pr_number):
        url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}'
        state = f'\"state\":\"closed\"'
        payload = "{\r\n" + state + "\r\n}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("PATCH", url, headers=headers, data=payload)

    def return_owner(self):
        owner = self.github_repo.split("/")
        return owner[0]

    def _comment_issue_without_pr(self, message_text, issue_number):
        #body = f'\"body\":\"{message_text}\"'

        url = f'https://api.github.com/repos/{self.github_repo}/issues/{issue_number}/comments'
        #payload = "{" + body + "}"
        payload = json.dumps({"body": message_text})

        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/javascript'
        }
        response = requests.request("POST", url, headers=headers, data=payload)


    def _comment_issue(self, branch, time_dif, issue_number, link_pr):
        message = f' The Branch {branch} has been inactive for more than {time_dif} days. ' \
               f'A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch.\nPull Request URL: {link_pr}'
        url = f'https://api.github.com/repos/{self.github_repo}/issues/{issue_number}/comments'
        payload = json.dumps({"body": message})
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/javascript'
        }
        response = requests.request("POST", url, headers=headers, data=payload)


    def _close_issue(self, issue_number):
        url = f'https://api.github.com/repos/{self.github_repo}/issues/{issue_number}'
        state = f'\"state\":\"closed\"'
        payload = "{" + state + "}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("PATCH", url, headers=headers, data=payload)

    def _get_issues(self):
        issue_list= []
        url = f'https://api.github.com/repos/{self.github_repo}/issues?per_page=100'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        issue_data = response.json()
        for issue in issue_data:
            try:
                issue["pull_request"]
            except KeyError:
                issue_list.append(issue["number"])
        return issue_list


    def _open_pr(self, branch, owner, time_dif):
        url = f'https://api.github.com/repos/{self.github_repo}/pulls'
        title = f'\"title\": \"The branch {branch} is closed because of too long inactivity.\"'
        body = f'\"body\":\"The Branch {branch} has been inactive for more than {time_dif} days. A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch.\"'
        head = f'\"head\":\"{owner}:{branch}\"'
        base = f'\"base\": \"{self.base_branch}\"'
        message = f'\n	{title},\n	{body},\n	{head},\n	{base}\n'
        payload = "{" + message + "}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("POST", url, headers=headers, data=payload)

        return response.json()

    def _assignees_issue(self, assignees_owner, issue_number):
        url = f'https://api.github.com/repos/{self.github_repo}/issues/{issue_number}/assignees'
        assignees = f'\"assignees\":[\"{assignees_owner}\"]'
        payload = "{" + assignees + "}"
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("POST", url, headers=headers, data=payload)

    def _update_pr_(self, pr_number, assignees_owner):

        url = f'https://api.github.com/repos/{self.github_repo}/issues/{str(pr_number)}'
        assignees = f'\"assignees\":[\"{assignees_owner}\"]'
        labels = f'\"labels\":[\"CI\"]'
        payload = "{\r\n" + assignees + ",\r\n" + labels + "\r\n}"
        headers = {
          'Authorization': 'Bearer ' + self.github_token,
          'Content-Type': 'application/json'
        }
        response = requests.request("PATCH", url, headers=headers, data=payload)
        print("User " + assignees_owner + " assignee to pull request Number " + str(pr_number))

    def _get_github_username(self, branch):
        url = f'https://api.github.com/repos/{self.github_repo}/branches/{branch}'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        branch = response.json()
        try:
            commit = branch["commit"]
            commit = commit["commit"]
            committer = commit["committer"]
            name = committer["name"]
            if name is not None:
                return name
        except KeyError:
            print(f'Github Username is unknown.')


    def _check_pr_number(self,pr_number):
        url = f'https://api.github.com/repos/{self.github_repo}/pulls/{pr_number}'
        payload = {}
        headers = {
            'Authorization': 'Bearer ' + self.github_token,
            'Content-Type': 'application/json'
        }
        response = requests.request("GET", url, headers=headers, data=payload)
        json_text = response.json()
        try:
            pull_url = json_text["url"]
            return pull_url
        except KeyError:
            print(f'Pull Request url is unknown.')



    def _post_message(self, channel_id, message_text):
        import logging
        from slack_sdk import WebClient  # Import WebClient from Python SDK (github.com/slackapi/python-slack-sdk)
        from slack_sdk.errors import SlackApiError
        #client = WebClient(token=os.environ.get("SLACK_BOT_TOKEN"))
        client = WebClient(token=self.slack_token)  # WebClient instantiates a client that can call API methods
        # When using Bolt, you can use either `app.client` or the `client` passed to listeners.
        logger = logging.getLogger(__name__)
        try:
            result = client.chat_postMessage(  # Call the chat.postMessage method using the WebClient
                channel=channel_id,
                text=message_text
            )
            logger.info(result)
        except SlackApiError as e:
            logger.error(f"Error posting message: {e}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Set Github Environment Variables")  # Configure the argument parser
    check_test_group = parser.add_argument_group("Arguments to set Environment Variables")
    check_test_group.add_argument('-GT', "--github-token", default="${GITHUB_API_TOKEN}", help="Your Set GITHUB Token")
    check_test_group.add_argument('-BB', "--base-branch", default="development", help="Your Set GITHUB Token")
    check_test_group.add_argument('-ST', "--slack-token", default="${secrets.SLACK_BOT_TOKEN}", help="Your Set GITHUB Token")
    check_test_group.add_argument("-GR", "--github-repo", default="SvenHinrichs/GitLabCI",
                                  help="Environment Variable owner/RepositoryName")
    args = parser.parse_args()  # Parse the arguments
    from api_slack import Slack_Notification
    slack = Slack_Notification(github_token=args.github_token, slack_token=args.slack_token, github_repo=args.github_repo, base_branch=args.base_branch)
    slack_user_list = slack._get_user_list()  # Get a list with all slack users
    slack_mail_id = slack._get_slack_mail(slack_user_list)  # Write dictionary with slack_mail: Slack_id
    local_time = slack._local_time()  # get the local time
    branch_list = slack._get_branches()  # write a branch list of your repository
    issue_number_list = slack._get_issues()  # get a list with number of issues
    artifacts_list = []  # List for github action artifacts
    for branch in branch_list:
        if branch == "development" or branch == "master":
            continue
        data_branch = slack._get_data(branch)  # get Information of branch: {'name': '****', 'email': '****', 'date': '****'}
        branch_information = data_branch[0]
        assignees_owner = data_branch[1]
        name = branch_information["name"]  # get the name from the last user who pushed to the branch
        github_mail = branch_information["email"]  # get the email from the last user who pushed to the branch
        last_push_time = slack._get_time(branch_information)  # get the date of the last push
        time_interval = str(local_time - last_push_time)  # time interval between last push and the local time
        if time_interval.find("days") > -1:
            time_dif = int(time_interval[:time_interval.find("days")])
            if time_dif > 180:
                if branch.find("Correct_HTML") > -1:
                    slack._delete_branch(branch)
                    continue
                print("******************************")
                time.sleep(3)
                channel_id = slack._get_slack_id(github_mail, slack_mail_id, name)  #  get the slack ID from the last user who pushed to the branch, if not found fg-modelica-id
                owner = slack.return_owner()
                reponse = slack._open_pr(branch, owner, time_dif)  # Open a pull request

                time.sleep(15)
                pr_number = slack._get_pr_number(branch)  # get the number of created pull request
                pull_url = slack._check_pr_number(pr_number)  # checks if the pull request with the number exists

                time.sleep(15)
                if pull_url is None:
                    print(f'Cannot create Pull Request: {reponse}')
                    artifacts_list.append(
                        f'\n******************************\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\nCannot create Pull Request: {reponse}\nThe branch {branch} has been inactive for more than {time_dif} days. ')
                    if str(reponse).find(f"'message': 'No commits between {args.base_branch} and {branch}'") > -1:
                        message_text = f'The branch {branch} has been inactive for more than {time_dif} days. ' \
                                       f'Cannot create a pull request, because there are no commits between {args.base_branch} and {branch}' \
                                       f'\nUser name: {name}'
                        print(f'\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\n{message_text}')
                        slack._post_message(channel_id, message_text)  # post message to slack user

                        #### Issue
                        branch_numb_list = (re.findall('[0-9]*', branch))  # write the number of branch (e.g. issue1170_*** -> 1170)
                        for numb in branch_numb_list:
                            if numb.isdigit() is True:  # get number of branch
                                for issue_number in issue_number_list:
                                    if str(issue_number) == str(numb):  # issue_number == branch_number
                                        if assignees_owner is not None:
                                            slack._assignees_issue(assignees_owner, issue_number)  # Add assigneers to the branch
                                        slack._comment_issue_without_pr(message_text, issue_number)  # comment the issue (delte the branch)
                                        time.sleep(5)
                                        slack._close_issue(issue_number)  # close issue

                        time.sleep(15)
                        slack._delete_branch(branch)  # delete branch
                        continue
                    if str(reponse).find(f"'message': 'You have exceeded a secondary rate limit and have been temporarily blocked from content creation. Please retry your request again later.'") > -1:
                        print(f'\nYou have exceeded a secondary rate limit and have been temporarily blocked from content creation. Please retry your request again later.\n')
                        exit(1)

                if assignees_owner is not None:
                    slack._update_pr_(pr_number, assignees_owner)  # Update the pull request: Assignees and labels

                link_branch = f'https://github.com/{args.github_repo}/tree/{branch}'
                link_pr = f'https://github.com/{args.github_repo}/pull/{str(pr_number)}'
                message_text = f'The branch {branch} has been inactive for more than {time_dif} days. ' \
                               f'A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch.' \
                               f'\nUser name: {name}' \
                               f'\nBranch URL: {link_branch}' \
                               f'\nPull Request URL: {link_pr}'
                print(f'\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\n{message_text}')

                artifacts_list.append(f'\n******************************\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\n{message_text}')
                #### Issue
                branch_numb_list = (re.findall('[0-9]*', branch))  # write the number of branch (e.g. issue1170_*** -> 1170)
                for numb in branch_numb_list:
                    if numb.isdigit() is True:  # get number of branch
                        for issue_number in issue_number_list:
                            if str(issue_number) == str(numb):  # issue_number == branch_number
                                if assignees_owner is not None:
                                    slack._assignees_issue(assignees_owner, issue_number)  # Add assigneers to the branch
                                slack._comment_issue(branch, time_dif, issue_number, link_pr)  # comment the issue (delte the branch)

                                time.sleep(15)
                                slack._close_issue(issue_number)  # close issue

                time.sleep(15)
                slack._post_message(channel_id, message_text)  # post message to slack user

                time.sleep(15)
                if pull_url is not None:
                    slack._close_pr(pr_number)  # close pull request
                    time.sleep(30)
                    slack._delete_branch(branch)  # delete branch
                else:
                    print(f'Cannot find pull request {pr_number}. The Branch {branch} will not be deleted.')
                continue

            if time_dif > 90:
                print("******************************")
                if branch.find("Correct_HTML") > -1:
                    continue
                time.sleep(3)
                channel_id = slack._get_slack_id(github_mail, slack_mail_id, name)
                link_branch = f'https://github.com/{args.github_repo}/tree/{branch}'
                message_text = f'The branch {branch} has been inactive for more than {time_dif} days. The branch is automatically deleted after 180 days. If you want to keep the branch, add changes to the branch.' \
                               f' A pull request is created and the branch is then deleted. If you want to restore the branch, go to the closed pull requests and restore your branch. ' \
                               f'\nUser name: {name}' \
                               f'\nBranch URL: {link_branch}'
                print(f'\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\n{message_text}')
                artifacts_list.append(
                    f'\n******************************\nName: {name}\nBranch: {branch}\nGitHub E-Mail: {github_mail}\nSlack_channel_ID: {channel_id}\n{message_text}')
                #### Issue
                branch_numb_list = (re.findall('[0-9]*', branch))  # write the number of branch (e.g. issue1170_*** -> 1170)
                for numb in branch_numb_list:
                    if numb.isdigit() is True:  # get number of branch
                        for issue_number in issue_number_list:
                            if str(issue_number) == str(numb):  # issue_number == branch_number
                                if assignees_owner is not None:
                                    slack._assignees_issue(assignees_owner, issue_number)  # Add assigneers to the branch
                                slack._comment_issue_without_pr(message_text, issue_number)  # comment the issue (delte the branch)
                                time.sleep(5)
                time.sleep(15)
                slack._post_message(channel_id, message_text)
                continue
            else:
                continue

    file = open(f'bin{os.sep}Configfiles{os.sep}ci_slack_branch_inactive_list.txt', "w")
    for entry in artifacts_list:
        file.write(entry)
    file.close()
    print("Check finished.")


