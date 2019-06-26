# User edit Form

## Responsibilities

- Render user edit form
- Display error messages

## Interfaces

```elm

import Data.Profile.Email exposing (Email)
import Data.Profile.Username exposing (Username)
import Data.Profile.Password exposing (Password)


type alias Problem =
    { key : String
    , problem : String
    }


type alias User =
    { username : Username
    , image : String
    , bio : String
    , email : Email
    }


type alias Labels =
    { heading : String
    , username : String
    , image : String
    , bio : String
    , email : String
    , password : String
    , submitButton : String
    }


type MsgIn
    = GotLabels Labels
    | EditUser Username
    | GotUser User
    | GotProblems (List Problem)
    | GotSuccess User


type MsgOut
    = ObserveUser Username
    | FormWasSubmitted
        { username : Maybe Username
        , image : Maybe String
        , bio : Maybe String
        , email : Maybe Email
        , password : Maybe Password
        }
    | SaveWasSuccessfull User

```

## Image

![User edit form screenshot](img/UserEditForm1.png)


## Template

```html

<h1 class="text-xs-center">Your Settings</h1>

<form>
  <fieldset>
      <fieldset class="form-group">
        <input class="form-control" type="text" placeholder="URL of profile picture">
      </fieldset>
      <fieldset class="form-group">
        <input class="form-control form-control-lg" type="text" placeholder="Your Name">
      </fieldset>
      <fieldset class="form-group">
        <textarea class="form-control form-control-lg" rows="8" placeholder="Short bio about you"></textarea>
      </fieldset>
      <fieldset class="form-group">
        <input class="form-control form-control-lg" type="text" placeholder="Email">
      </fieldset>
      <fieldset class="form-group">
        <input class="form-control form-control-lg" type="password" placeholder="Password">
      </fieldset>
      <button class="btn btn-lg btn-primary pull-xs-right">
        Update Settings
      </button>
  </fieldset>
</form>
```
