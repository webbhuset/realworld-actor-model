# Register Form

## Responsibilities

- Register account form
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
    }


type alias Labels =
    { email : String
    , username : String
    , password : String
    , heading : String
    , haveAnAccount : String
    , haveAnAccountHref : String
    , submitButton : String
    }

type MsgIn
    = GotLabels Labels
    | GotProblems (List Problem)
    | GotCreateSuccess User


type MsgOut
    = FormWasSubmitted
        { username : Username
        , email : Email
        , password : Password
        }
    | CreateWasSuccessfull User

```

## Image

![Register form screenshot](img/RegisterForm1.png)


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
