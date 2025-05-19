package main.java.com.movieticket.dao;

import main.java.com.movieticket.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String DATA_FILE = "F:\\SLIIT\\Y1S2\\OOP\\Assignment\\MovieReservation\\MovieReservation\\src\\main\\data/users.txt";
    private static final String DELIMITER = "\\|";

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(DELIMITER);
                if (fields.length >= 5) {
                    User user = new User(
                            fields[0],           // userId
                            fields[1],           // name
                            fields[2],           // email
                            fields[3],           // passwordHash
                            fields[4]            // role
                    );
                    users.add(user);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean createUser(User user) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, true))) {
            bw.write(formatUser(user));
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User updatedUser) {
        List<User> users = getAllUsers();
        boolean found = false;
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUserId().equals(updatedUser.getUserId())) {
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return rewriteFile(users);
    }

    public boolean deleteUser(String userId) {
        List<User> users = getAllUsers();
        boolean removed = users.removeIf(u -> u.getUserId().equals(userId));
        if (!removed) return false;
        return rewriteFile(users);
    }

    private boolean rewriteFile(List<User> users) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, false))) {
            for (User u : users) {
                bw.write(formatUser(u));
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String formatUser(User user) {
        // Format: userId|name|email|passwordHash|role
        return user.getUserId() + "|" + user.getName() + "|" + user.getEmail() + "|" + user.getPasswordHash() + "|" + user.getRole();
    }

    public User getUserById(String userId) {
        for (User u : getAllUsers()) {
            if (u.getUserId().equals(userId)) return u;
        }
        return null;
    }
}
