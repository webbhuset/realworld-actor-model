# Login Form

## Responsibilities

- Render login form inputs
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


type MsgIn
    = InitLabels
        { email : String
        , password : String
        , heading : String
        , needAccount : String
        , needAccountHref : String
        }
    | RecvProblems (List Problem)
    | RecvLoginSuccess User


type MsgOut
    = FormWasSubmitted
        { username : String
        , password : String
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
