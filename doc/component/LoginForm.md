# Login Form

A login form component. Sends email/password to the
[user service] component when the form is submitted.


## Responsibilities

- Render login form inputs
- Display error messages

## Interfaces

```elm

import Data.Profile.Username exposing (Username)
import Data.Profile.Email exposing (Email)
import Data.Profile.Password exposing (Password)


type alias Problem =
    { key : String
    , problem : String
    }


type alias User =
    { username : Username
    }


type alias Labels =
    { email : String
    , password : String
    , heading : String
    , needAnAccount : String
    , needAnAccountHref : String
    , submitButton : String
    }


type MsgIn
    = GotLabels Labels
    | GotProblems (List Problem)
    | GotLoginSuccess User


type MsgOut
    = FormWasSubmitted
        { email : Email
        , password : Password
        }
    | LoginWasSuccessfull User

```

## Image

![Login form screenshot](img/LoginForm1.png)

## Image, with error message

![Login form screenshot](img/LoginForm2.png)

## Template

```html

<div>
    <h1 class="text-xs-center">Sign up</h1>
    <p class="text-xs-center">
        <a href="">Have an account?</a>
    </p>

    <ul class="error-messages">
        <li>That email is already taken</li>
    </ul>

    <form>
        <fieldset class="form-group">
            <input class="form-control form-control-lg" type="text" placeholder="Your Name">
        </fieldset>
        <fieldset class="form-group">
            <input class="form-control form-control-lg" type="text" placeholder="Email">
        </fieldset>
        <fieldset class="form-group">
            <input class="form-control form-control-lg" type="password" placeholder="Password">
        </fieldset>
        <button class="btn btn-lg btn-primary pull-xs-right">Sign up</button>
    </form>
</div>

```

[user service]: UserService.md
