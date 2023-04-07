## Section 15: SQL Database Trigger
**1. Definition:**

A database trigger is procedural code that is automatically executed in response to certain events on a particular table or view in a database. The trigger is mostly used for maintaining the integrity of the information on the database.

**2. Create table to explain concept**
```sql
CREATE TABLE users (
  username VARCHAR(100),
  age INT
);

-- delimiter create an execution block
DELIMITER $$
  CODE
$$
DELIMITER ;

-- TRIGGER template
DELIMITER $$ 
CREATE TRIGGER triggerName
  triggerTime triggerEvent ON tablename FOR EACH ROW
  BEGIN
    DO SOMETHING HERE
  END;
$$
DELIMITER ;

-- checking age before insert data
DELIMITER $$

CREATE TRIGGER must_be_adult
  BEFORE INSERT ON users FOR EACH ROW
  BEGIN
    IF NEW.age < 18
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Must be an adult!';
    END IF;
  END;
$$

DELIMITER ;

-- the following instruction won't work after adding the above trigger
INSERT INTO users(username, age)
VALUES("Tim", 15); -- Tim's age < 18
```

**3. Trigger to prevent following users themselves (Above Instagram Clone Database)**
```sql
DELIMITER $$

CREATE TRIGGER prevent_self_follows
  BEFORE INSERT ON follows FOR EACH ROW
  BEGIN
    IF NEW.follower_id = NEW.followee_id
    THEN 
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'You cannot follow yourself!';
    END IF;
  END;
$$

DELIMITER ;
```

**4. Trigger to Capture unfollowers**
```sql
DELIMITER $$

CREATE TRIGGER capture_unfollow
  AFTER DELETE ON follows FOR EACH ROW
  BEGIN
    INSERT INTO unfollows
    SET
      follower_id = OLD.follower_id,
      followee_id = OLD.followee_id;
  END;
$$

DELIMITER ;
```

**5. Listing TRIGGER**
```sql
SHOW TRIGGERS;
```

**6. Drop TRIGGER**
```sql
DROP TRIGGER trigger_name;
```
