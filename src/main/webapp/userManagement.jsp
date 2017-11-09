<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Management</title>
<script
	src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script type="text/javascript">
	var app = angular.module('app', []);

	app.controller('appController', function($scope, $http) {
		$scope.users = []
		$scope.userform = {
			name : "",
			department : ""
		};

		getUserDetails();

		function getUserDetails() {
			$http({
				method : 'GET',
				url : 'userModel'
			}).then(function successCallback(response) {
				$scope.users = response.data;
			}, function errorCallback(response) {
				console.log(response.statusText);
			});
		}

		$scope.processUser = function() {
			$http({
				method : 'POST',
				url : 'user',
				data : angular.toJson($scope.userform),
				headers : {
					'Content-Type' : 'application/json'
				}
			}).then(getUserDetails(), clearForm()).success(function(data) {
				$scope.users = data
			});
		}

		$scope.editUser = function(user) {
			$scope.userform.firstName = user.firstName;
			$scope.userform.lastName = user.lastName;
			disableName();
		}

		$scope.deleteUser = function(user) {
			$http({
				method : 'DELETE',
				url : 'deleteUser',
				data : angular.toJson(user),
				headers : {
					'Content-Type' : 'application/json'
				}
			}).then(getUserDetails());
		}

		function clearForm() {
			$scope.userform.firstName = "";
			$scope.userform.lastName = "";
			document.getElementById("firstName").disabled = false;
		}

		function disableName() {
			document.getElementById("firstName").disabled = true;
		}
	});
</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body ng-app="app" ng-controller="appController">
	<h3>User Registration Form</h3>
	<form ng-submit="processUserDetails()">
		<div class="table-responsive">
			<table class="table table-bordered" style="width: 600px">
				<tr>
					<td>FirstName</td>
					<td><input type="text" id="firstName"
						ng-model="userform.firstName" size="30" /></td>
				</tr>
				<tr>
					<td>LastName</td>
					<td><input type="text" id="lastName"
						ng-model="userform.lastName" size="30" /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit"
						class="btn btn-primary btn-sm" ng-click="processUser()"
						value="Create / Update User" /></td>
				</tr>
			</table>
		</div>
	</form>
	<h3>Registered Users</h3>
	<div class="table-responsive">
		<table class="table table-bordered" style="width: 600px">
			<tr>
				<th>FirstName</th>
				<th>LastName</th>
				<th>Actions</th>
			</tr>

			<tr ng-repeat="user in users">
				<td>{{ user.firstName}}</td>
				<td>{{ user.lastName }}</td>
				<td><a ng-click="editUser(user)" class="btn btn-primary btn-sm">Edit</a>
					| <a ng-click="deleteUser(user)" class="btn btn-danger btn-sm">Delete</a></td>
			</tr>
		</table>
	</div>
</body>
</html>