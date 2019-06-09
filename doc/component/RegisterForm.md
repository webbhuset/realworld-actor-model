# Register Form

## Responsibilities

- Register account form
- Display error messages

## Interfaces

```elm

type alias Problem =
    { key : String
    , problem : String
    }


type alias User =
    { username : String
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
    = InitLabels Labels
    | RecvProblems (List Problem)
    | RecvCreateSuccess User


type MsgOut
    = FormWasSubmitted
        { username : String
        , email : String
        , password : String
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
