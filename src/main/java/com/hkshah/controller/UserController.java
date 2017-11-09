package com.hkshah.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hkshah.model.UserModel;

@RestController
public class UserController {
	public List<UserModel> userModelList = new ArrayList<UserModel>();

	public UserController() {
		userModelList.add(new UserModel("Hardik", "Shah"));
		userModelList.add(new UserModel("Bhavik", "Shah"));
	}

	@RequestMapping(value = "/userModel", method = RequestMethod.GET, produces = "application/json")
	public List<UserModel> getUserModel() {
		return userModelList;
	}

	@RequestMapping(value = "/user", consumes = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.POST)
	public List<UserModel> processUser(@RequestBody UserModel userModel) {
		boolean nameExist = false;

		for (UserModel ud : userModelList) {
			if (ud.getFirstName().equals(userModel.getFirstName())) {
				nameExist = true;
				ud.setLastName(userModel.getLastName());
				break;
			}
		}
		if (!nameExist) {
			userModelList.add(userModel);
		}

		return userModelList;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/deleteUser", consumes = MediaType.APPLICATION_JSON_VALUE, method = RequestMethod.DELETE)
	public ResponseEntity DeleteUser(@RequestBody UserModel userModel) {
		Iterator<UserModel> it = userModelList.iterator();
		while (it.hasNext()) {
			UserModel uModel = (UserModel) it.next();
			if (uModel.getFirstName().equals(userModel.getFirstName()))
				it.remove();
		}
		return new ResponseEntity(HttpStatus.OK);
	}
}